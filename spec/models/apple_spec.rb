require 'spec_helper'

describe "Apple Model" do
  let(:apple) { Apple.new }
  it 'can be created' do
    apple.should_not be_nil
  end
end
