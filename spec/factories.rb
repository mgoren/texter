FactoryGirl.define do
  factory :user do
    username "username"
    email "username@domain.tld"
    password "password"
  end

  factory :contact do
    name "foo"
    phone "555-555-5555"
    user
  end

  factory :message do
    to ENV['TO_PHONE_NUMBER']
    from ENV['FROM_PHONE_NUMBER']
    body "Hello World!"
    contact
  end
end
