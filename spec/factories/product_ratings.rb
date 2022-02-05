# == Schema Information
#
# Table name: product_ratings
#
#  id           :uuid             not null, primary key
#  author       :string           not null
#  rating       :integer          not null
#  review_body  :string
#  review_title :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :uuid
#
FactoryBot.define do
  factory :product_rating do
    author { Faker::Name.unique.name }
    rating { rand(1..5) }
    review_title { 'This product is great' }
    review_body { Faker::Quote.yoda }
    product_id { FactoryBot.create(:product).id }
  end
end
