class CreateLocationsRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_join_table :restaurants, :locations do |t|
      t.index [:restaurant_id, :location_id]
      t.index [:location_id, :restaurant_id]

      t.timestamps
    end
  end
end
