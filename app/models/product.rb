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
  has_many :product_ratings

  def average_rating
    ratings = []
    product_ratings.each do |product_rating|
      ratings.append(product_rating.rating)
    end

    return 0 unless ratings.present?

    ratings.sum(0.0) / ratings.size
  end
end
