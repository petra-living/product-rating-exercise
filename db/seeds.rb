# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |i|
  Product.create(name: "product-#{i}", description: "Product #{i}")
end

5.times do |i|
  rating = rand(1..5)
  Review.create(author: "Daniel", rating: rating, headline: rating >= 3 ? "Nice Job":"Bad Job", product: Product.all.sample(1).first)
end
