class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews, id: :uuid do |t|
      t.string :author, null: false
      t.integer :rating, null: false
      t.string :headline, null: false
      t.string :body
      t.uuid :product_id, null: false

      t.timestamps
    end
  end
end
