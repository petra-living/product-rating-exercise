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
class ProductRating < ApplicationRecord
  belongs_to :product

  validates :rating, :presence => true, :inclusion => { :in => 1..5 }
  validates :author, :presence => true
  validates :review_title, :presence => true
end
