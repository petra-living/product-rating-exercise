# == Schema Information
#
# Table name: reviews
#
#  id         :uuid             not null, primary key
#  author     :string           not null
#  body       :string
#  headline   :string           not null
#  rating     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :uuid
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Review < ApplicationRecord
  belongs_to :product
end
