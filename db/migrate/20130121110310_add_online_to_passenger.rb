class AddOnlineToPassenger < ActiveRecord::Migration
  def change
    add_column :passengers, :online, :integer, :default => 0
  end
end
