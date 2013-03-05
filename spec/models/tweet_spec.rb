require 'spec_helper'

describe "Tweet Model" do
  let(:tweet) { Tweet.new }
  it 'can be created' do
    tweet.should_not be_nil
  end
end
