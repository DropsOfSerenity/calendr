FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "validpassword"
    password_confirmation "validpassword"
  end
end
