require "rails_helper"

describe Contact do
  it { should have_many :messages }
  it { should belong_to :user }
  it { should validate_presence_of :phone }
  it { should validate_uniqueness_of :phone }

  it "passes validation without a name but with default empty name string" do
    contact = FactoryGirl.create(:contact)
    expect(contact.name).to eq("")
  end

end
