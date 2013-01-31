class AddPassengerIdToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :passenger_id, :integer, :null => false
    add_column :trips, :start_lat, :string, :null => false
    add_column :trips, :start_lng, :string, :null => false
    add_column :trips, :end_lat, :string
    add_column :trips, :end_lng, :string
  end
end
