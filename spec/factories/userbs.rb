FactoryBot.define do
  factory :userb do
    name { Faker::Name.name }
    email { 'foo@bar.com' }
    password { 'foobar' }
  end
end
