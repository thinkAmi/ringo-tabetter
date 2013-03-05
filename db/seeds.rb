# -*- coding: utf-8 -*-
require 'twitter'

# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#


email     = shell.ask "Which email do you want use for logging into admin?"
password  = shell.ask "Tell me the password to use:"


shell.say ""

account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

if account.valid?
  shell.say "================================================================="
  shell.say "Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   password: #{password}"
  shell.say "================================================================="
else
  shell.say "Sorry but some thing went wrong!"
  shell.say ""
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""


# Apple
# Twitterは最大2,000ツイート分検索する
# (TwitterAPI ver1.1や、検索上限3,200ツイートも考慮)
keys, client, apples = get_run_info

timeline = client.user_timeline(keys[:target_timeline_user], count: 200)

since_id = timeline.first.id
max_id = 0

timeline.each do |response|
  update_apple(apples, response)

  max_id = response.id
end


# Twitter Gemで、引数のmax_idが変化しなくなったら、Twitterでの検索をやめる
2.step(9, 1){ |i|
  last_max_id = max_id

  client.user_timeline(keys[:target_timeline_user], count: 200, max_id: max_id).each do |response|
    unless max_id == response.id
      update_apple(apples, response)

      max_id = response.id
    end
  end

  break if last_max_id == max_id
}


Tweet.create(
  last_searched_id: since_id
  )