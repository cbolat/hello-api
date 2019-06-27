FactoryBot.define do
  factory :user_p do
    name { Faker::Name.name }
    email 'foo@bar.com'
    password 'foobar'
  end
end
