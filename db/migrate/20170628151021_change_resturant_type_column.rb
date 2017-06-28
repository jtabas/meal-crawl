class ChangeResturantTypeColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :restaurants, :type, :food_type
  end
end
