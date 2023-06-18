require 'faker'

FactoryGirl.define do
  factory :user do
    name Faker::Name.unique.name
  end
end