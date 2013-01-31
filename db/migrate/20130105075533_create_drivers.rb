class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :mobile
      t.string :lat
      t.string :lng
      t.string :password
      t.string :car_license
      t.string :car_type
      t.string :car_service_number
      t.integer :rate

      t.timestamps
    end
  end
end
