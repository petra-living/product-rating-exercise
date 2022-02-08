class ReviewSerializer
  include JSONAPI::Serializer
  attributes :id, :author, :headline, :rating, :body, :created_at, :product_id
  set_type :review
  belongs_to :product
end
