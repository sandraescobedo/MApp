require 'faker'

FactoryBot.define do
  factory :user do
    before(:create)   { |user| user.skip_confirmation! }
    email             { Faker::Internet.email }
    password          { Faker::Alphanumeric.alpha 15 }
    role              { 'traveller' }
  end
end
