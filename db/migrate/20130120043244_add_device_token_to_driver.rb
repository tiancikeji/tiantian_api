class AddDeviceTokenToDriver < ActiveRecord::Migration
  def change
    add_column :drivers, :androidDevice, :string
    add_column :drivers, :iosDevice, :string
  end
end
