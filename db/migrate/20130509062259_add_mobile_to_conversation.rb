class AddMobileToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :mobile, :string
  end
end
