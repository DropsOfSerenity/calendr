FactoryGirl.define do
  factory :homework do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(1) }
    user
    subject
    due_date Time.now

    trait :due_tomorrow do
      due_date { Time.now + 1.day }
    end

    trait :due_next_week do
      due_date { Time.now + 1.week }
    end

    trait :due_next_year do
      due_date { Time.now + 1.year }
    end

    trait :already_past do
      due_date { Time.now - 1.week }
    end

    trait :already_way_past do
      due_date { Time.now - 1.year }
    end

  end

end
