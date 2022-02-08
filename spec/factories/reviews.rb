# == Schema Information
#
# Table name: reviews
#
#  id         :uuid             not null, primary key
#  author     :string           not null
#  body       :string           default(""), not null
#  headline   :string           not null
#  rating     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :uuid             not null
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :review do
    author { "MyString" }
    rating { 1 }
    headline { "MyString" }
    body { "MyString" }
  end
end
