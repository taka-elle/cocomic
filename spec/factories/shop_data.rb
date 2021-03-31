FactoryBot.define do
  factory :shop_datum do
    text         {Faker::Lorem.paragraph}
    association :shop

    after(:build) do |shop_datum|
      shop_datum.image1.attach(io: File.open('app/assets/images/cocomic-shop-demo.jpg'), filename: 'cocomic-shop-demo.jpg', content_type: 'image/jpg')
      shop_datum.image2.attach(io: File.open('app/assets/images/cocomic-shop-demo.jpg'), filename: 'cocomic-shop-demo.jpg', content_type: 'image/jpg')
      shop_datum.image3.attach(io: File.open('app/assets/images/cocomic-shop-demo.jpg'), filename: 'cocomic-shop-demo.jpg', content_type: 'image/jpg')
      shop_datum.image4.attach(io: File.open('app/assets/images/cocomic-shop-demo.jpg'), filename: 'cocomic-shop-demo.jpg', content_type: 'image/jpg')
      shop_datum.image5.attach(io: File.open('app/assets/images/cocomic-shop-demo.jpg'), filename: 'cocomic-shop-demo.jpg', content_type: 'image/jpg')
    end
  end
end
