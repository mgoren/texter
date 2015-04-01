require "rails_helper"

describe "the message sending process", vcr: true do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login(user)
  end

  it "sends a message" do
    visit new_message_path
    fill_in "To", with: ENV['TO_PHONE_NUMBER']
    fill_in "Body", with: "Capybara is working!"
    click_button "Send"
    expect(page).to have_content "sent"
  end
end
