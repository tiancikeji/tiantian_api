class AddOnlineToDriver < ActiveRecord::Migration
  def change
    add_column :drivers, :online, :integer, :default => 0
  end
end
