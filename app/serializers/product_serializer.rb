require 'date'

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :average_rating

  def average_rating
    object.average_rating.round(2)
  end
end
