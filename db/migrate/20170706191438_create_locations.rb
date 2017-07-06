class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.integer :lat, null: false
      t.integer :long, null: false

      t.timestamps
    end
  end
end
