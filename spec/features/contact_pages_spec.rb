require 'rails_helper'

describe "the contact creation process" do
  it "creates a contact" do
    user = FactoryGirl.create(:user)
    login(user)
    visit new_user_contact_path(user)
    fill_in "Name", with: 'Generic Name'
    fill_in "Phone", with: "555-555-5555"
    click_button "Save Contact"
    expect(page).to have_content "saved"
  end

  it "fails gracefully when a new contact phone is not unique" do
    user = FactoryGirl.create(:user)
    login(user)
    visit new_user_contact_path(user)
    fill_in "Name", with: 'Generic Name'
    fill_in "Phone", with: "555-555-5555"
    click_button "Save Contact"
    visit new_user_contact_path(user)
    fill_in "Name", with: 'Generic Name'
    fill_in "Phone", with: "555-555-5555"
    click_button "Save Contact"
    expect(page).to have_content "This contact is already in your phone book"
  end

  it "shows individual contact details" do
    contact = FactoryGirl.create(:contact)
    user = contact.user
    login(user)
    visit user_path(user)
    click_link contact.name
    expect(page).to have_content contact.phone
  end

  it "edits contact details" do
    contact = FactoryGirl.create(:contact)
    user = contact.user
    login(user)
    visit user_contact_path(user, contact)
    click_on 'Edit'
    fill_in "Name", with: "bar"
    click_button 'Save Contact'
    expect(page).to have_content 'bar'
  end

  it "destroys a contact" do
    contact = FactoryGirl.create(:contact)
    user = contact.user
    login(user)
    visit user_contact_path(user, contact)
    click_on 'Delete'
    expect(page).to have_content "deleted"
  end
end

describe "how contacts and messages relate", vcr: true do
  it "the message history on contact page" do
    message = FactoryGirl.create(:message)
    contact = message.contact
    user = contact.user
    login(user)
    visit user_contact_path(user, contact)
    expect(page).to have_content message.body
  end
end
