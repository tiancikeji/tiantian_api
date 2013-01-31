class AddDeviceTokenToPassenger < ActiveRecord::Migration
  def change
    add_column :passengers, :iosDevice, :string
    add_column :passengers, :androidDevice, :string
  end
end
