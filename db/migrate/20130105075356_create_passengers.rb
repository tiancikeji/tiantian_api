class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :mobile
      t.string :lat
      t.string :lng
      t.string :password

      t.timestamps
    end
  end
end
