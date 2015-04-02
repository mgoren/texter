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

  it "associates message with new contact" do
    visit new_message_path
    fill_in "To", with: ENV['TO_PHONE_NUMBER']
    fill_in "Body", with: "testing associating message with new contact"
    click_button "Send"
    expect(Contact.first.phone).to eq(ENV['TO_PHONE_NUMBER'])
  end

  it "associates message with existing contact" do
    contact = FactoryGirl.create(:contact, user: user, phone: ENV['TO_PHONE_NUMBER'])
    visit new_message_path
    fill_in "To", with: contact.phone
    fill_in "Body", with: "testing associating message with existing contact"
    click_button "Send"
    expect(Message.first.contact).to eq(contact)
  end

  it "associates message with user through contact" do
    visit new_message_path
    fill_in "To", with: ENV['TO_PHONE_NUMBER']
    fill_in "Body", with: "testing associating message with new contact"
    click_button "Send"
    expect(Contact.first.user).to eq(User.first)
  end

end
