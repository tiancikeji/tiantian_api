class AddTripToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :appointment, :string
    add_column :conversations, :end, :string
    add_column :conversations, :start, :string
    add_column :conversations, :passenger_id, :integer
    add_column :conversations, :start_lat, :string, :null=>false
    add_column :conversations, :start_lng, :string, :null=>false
    add_column :conversations, :end_lat, :string, :null=>false
    add_column :conversations, :end_lng, :string, :null=>false
    add_column :conversations, :price, :string
  end
end
