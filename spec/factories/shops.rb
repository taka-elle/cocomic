FactoryBot.define do
  factory :shop do
    name                  { 'Test' }
    email                 { Faker::Internet.free_email }
    password              { 'test111' }
    password_confirmation { password }
    area_id               { 13 }
    city                  { '豊島区東池袋' }
    add_line              { '3−１' }
    build                 { 'サンシャインシティワールドインポートマートビル屋上' }
  end
end
