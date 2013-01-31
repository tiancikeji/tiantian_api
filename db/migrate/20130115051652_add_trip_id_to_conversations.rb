class AddTripIdToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :trip_id, :integer, :null => false
    add_column :conversations, :content, :string
  end
end
