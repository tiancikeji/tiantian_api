class AddPriceToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :price, :string
  end
end
