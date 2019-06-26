FactoryBot.define do
  factory :order do
    name { Faker::Hacker.noun }
    done  false
    todo_id  nil
  end
end
