FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "validpassword"
    password_confirmation "validpassword"

    factory :user_with_homeworks do
      transient do
        homeworks_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:homework, evaluator.homeworks_count, user: user)
      end
    end
  end
end
