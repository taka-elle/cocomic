FactoryBot.define do
  factory :user do
    name            { 'Test' }
    email           { Faker::Internet.free_email }
    password              { 'test111' }
    password_confirmation { password }
  end
end
