class ChangeAppointmentTypeToIntConversation < ActiveRecord::Migration
  def up
    change_column :conversations, :appointment, :integer, :default => 0
  end

  def down
    change_column :conversations, :appointment, :string
  end
end
