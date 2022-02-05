class CreateProductRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :product_ratings, id: :uuid do |t|
      t.string :author, null: false
      t.integer :rating, null: false, inclusion: [1, 2, 3, 4, 5]
      t.string :review_title, null: false
      t.string :review_body
      t.uuid :product_id

      t.timestamps
    end
  end
end
