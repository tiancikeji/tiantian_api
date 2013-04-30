class AddLeftToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :left, :integer
  end
end
