# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :uuid             not null, primary key
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_products_on_name  (name) UNIQUE
#

class Product < ApplicationRecord
  has_many :reviews

  def total_average_rating
    1.0 * reviews.sum(:rating) / reviews.count
  end

  def self.ordered_by_rating_desc
    reviews = Review.all
    sums = reviews.group(:product_id).sum(:rating)
    counts = reviews.group(:product_id).count
    reviews_hash = {}
    sums.each do |key, value|
      reviews_hash[key] = 1.0 * value / counts[key]
    end
    # reviews_hash = { uuid1: value1, uuid3: value3, uuid2: value2 }
    # sort_by -> [[uuid1, value1], [uuid2, value2], [uuid3, value3]]
    # map     -> [uuid1, uuid2, uuid3]
    # reverse -> [uuid3, uuid2, uuid1]
    uuids = reviews_hash.sort_by { |uuid, value| value }.map { |uuid_and_value| uuid_and_value.first }.reverse
    Product.find(uuids)
  end
end
