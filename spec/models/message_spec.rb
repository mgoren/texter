require 'rails_helper'

describe Message, vcr: true do

  it "sends a message" do
    message = FactoryGirl.build(:message)
    expect(message.save).to eq true
  end

  it 'adds an error if the to number is invalid' do
    message = FactoryGirl.build(:message, to: '1111111')
    message.save
    expect(message.errors.messages[:base]).to eq ["The 'To' number 1111111 is not a valid phone number."]
  end

  it "sends a message to a phone number with non-numerals" do
    message = FactoryGirl.build(:message, to: '917-309-5698')
    expect(message.save).to eq true
  end

end
