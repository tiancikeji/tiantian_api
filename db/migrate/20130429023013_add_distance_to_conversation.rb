class AddDistanceToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :distance, :string
  end
end
