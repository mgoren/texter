require 'rails_helper'

describe Message, vcr: true do

  it "sends a message" do
    message = Message.new(body: "Hello World", to: ENV['TO_PHONE_NUMBER'], from: ENV['FROM_PHONE_NUMBER'])
    expect(message.save).to be true
  end

end
