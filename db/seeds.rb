# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |i|
  product = FactoryBot.create(:product, name: "product-#{i}", description: "Product #{i}")
  3.times do |_j|
    FactoryBot.create(:product_rating, :product_id => product.id)
  end
end
