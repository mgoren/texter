class Message < ActiveRecord::Base
  before_validation :normalize_phone_number
  before_create :send_sms

private
  def normalize_phone_number
    to.gsub(/[^0-9]/, "")
    if to.length == 11 && to.first == "1"
      to = to[1..10]
    end
  end

  def send_sms
    begin
      response = RestClient::Request.new(
        method: :post,
        url: "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
        user: ENV['TWILIO_ACCOUNT_SID'],
        password: ENV['TWILIO_AUTH_TOKEN'],
        payload: { Body: body, To: to, From: from }
      ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      false
    end
  end
end
