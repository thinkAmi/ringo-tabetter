# -*- coding: utf-8 -*-
require 'twitter'
require 'active_support/all'


task gather_timeline: :environment do
  keys, client, apples = get_run_info

  tweet = Tweet.first
  searched_id = tweet.last_searched_id

  timeline = client.user_timeline(keys[:target_timeline_user], count: 200, since_id: searched_id)

  next if timeline.size == 0


  searched_id = timeline.first.id

  timeline.each do |response|
    update_apple(apples, response, validation: ->(x){ no_tag?(x) })
  end

  tweet.last_searched_id = searched_id
  tweet.save
end


def get_run_info
  keys = get_twitter_api_keys
  client = get_twitter_client(keys)
  apples = YAML.load_file("apples.yaml")

  return keys, client, apples
end


def get_twitter_client(keys)
  Twitter.configure do |config|
    config.consumer_key = keys[:twitter_consumer_key]
    config.consumer_secret = keys[:twitter_consumer_secret]
  end

  client = Twitter::Client.new(
    oauth_token: keys[:twitter_oauth_token],
    oauth_token_secret: keys[:twitter_oauth_token_secret]
  )

  client
end


def get_twitter_api_keys

  if ENV["PADRINO_ENV"] == "production"
    keys = {
      target_timeline_user: ENV["TARGET_TIMELINE_USER"],
      twitter_consumer_key: ENV["TWITTER_CONSUMER_KEY"],
      twitter_consumer_secret: ENV["TWITTER_CONSUMER_SECRET"],
      twitter_oauth_token: ENV["TWITTER_OAUTH_TOKEN"],
      twitter_oauth_token_secret: ENV["TWITTER_OAUTH_TOKEN_SECRET"]
    }

  else
    HashWithIndifferentAccess.new(YAML.load_file("api_key.yaml"))
  end
end


def no_tag?(text)
  text !~ /^\[リンゴ\]/
end


def update_apple(apples, response, args = {})
  return if args[:validation] && args[:validation].call(response.text)

  apples.each do |key, value|
    if response.text.include?(key)
      model = Apple.new(
        name: key,
        tweet_id: response.id,
        tweeted_at: response.created_at,
        tweet: response.text,
        )
      model.save

    end
  end
end