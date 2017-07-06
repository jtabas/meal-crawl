class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.string :body
      t.integer :restaurant_id
      t.integer :user_id
      t.timestamps
    end
  end
end
