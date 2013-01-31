class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :start
      t.string :end
      t.string :appointment

      t.timestamps
    end
  end
end
