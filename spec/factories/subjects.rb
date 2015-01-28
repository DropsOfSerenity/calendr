FactoryGirl.define do
  factory :subject do
    sequence(:name) { |n| "#{Faker::Lorem.word}#{n}" }
    color "#3305db"
    user
  end
end
