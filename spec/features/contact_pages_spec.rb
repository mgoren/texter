require 'rails_helper'

describe "the contact creation process" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login(user)
  end

  it "creates a contact" do
    visit new_user_contact_path(user)
    fill_in "Name", with: 'Generic Name'
    fill_in "Phone", with: "555-555-5555"
    click_button "Save Contact"
    expect(page).to have_content "saved"
  end

  it "fails gracefully when a new contact phone is not unique" do
    visit new_user_contact_path(user)
    fill_in "Name", with: 'Generic Name'
    fill_in "Phone", with: "555-555-5555"
    click_button "Save Contact"
    visit new_user_contact_path(user)
    fill_in "Name", with: 'Generic Name'
    fill_in "Phone", with: "555-555-5555"
    click_button "Save Contact"
    expect(page).to have_content "Some kind of error."
  end
end
