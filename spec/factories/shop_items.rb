FactoryBot.define do
  factory :shop_item do
    isbn            { 9784088824239 }
    association :shop
  end
end
