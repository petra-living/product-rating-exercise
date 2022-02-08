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
class Review < ApplicationRecord
  belongs_to :product

  validates :author, presence: true
  validates :headline, presence: true
  validates :rating, presence: true, inclusion: (1..5).to_a
  validates :product, presence: true
  # excludes explicit {..., body: nil, ...}, allows empty string, allows no body
  validates :body, exclusion: [nil]
end
