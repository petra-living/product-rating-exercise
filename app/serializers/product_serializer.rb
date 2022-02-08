class ProductSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :created_at, :updated_at

  set_type :product
  has_many :reviews

  attribute :average_rating do |product|
    product.total_average_rating
  end
end
