class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.string :body
      t.integer :restaurant_id
      t.integer :reviews, :user_id, :integer, null: false, default: 0
      t.timestamps
    end
    add_index :reviews, :restaurant_id
  end
end
