FactoryBot.define do
  factory :ticket do
    get_day         {Faker::Date.in_date_period}
    having_day      {1}
    isbn            { 1234567890123 }
    association :user
    association :shop_item
  end
end
