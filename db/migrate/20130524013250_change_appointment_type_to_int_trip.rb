class ChangeAppointmentTypeToIntTrip < ActiveRecord::Migration
  def up
    change_column :trips, :appointment, :integer, :default => 0
  end

  def down
    change_column :trips, :appointment, :string
  end
end
