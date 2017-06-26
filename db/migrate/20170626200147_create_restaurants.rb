class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :type, null: false
      t.string :zipcode, null: false
      t.string :hours
      t.string :website
      t.string :phone
      t.timestamps
    end
  end
end
