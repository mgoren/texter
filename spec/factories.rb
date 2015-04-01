FactoryGirl.define do
  factory :message do
    to ENV['TO_PHONE_NUMBER']
    from ENV['FROM_PHONE_NUMBER']
    body "Hello World!"
  end

  factory :user do
    username "username"
    email "username@domain.tld"
    password "password"
  end
end
