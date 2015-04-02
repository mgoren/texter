class Contact < ActiveRecord::Base
  has_many :messages
  belongs_to :user
  validates :phone, presence: true
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # after_validation :normalize_phone_number

  def normalize_phone_number
    self.phone.gsub!(/[^0-9]/, "")
    if self.phone.length == 11 && self.phone.first == "1"
      self.phone = self.phone[1..10]
    end
  end
end
