FactoryGirl.define do
  factory :client do
    name "MyString"
    email "MyString"
    down_payment 1
    down_payment_type 1
    interest_rate 1
    amort 1
    agent nil
  end
end
