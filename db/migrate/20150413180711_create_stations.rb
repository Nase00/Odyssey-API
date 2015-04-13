class CreateStations < ActiveRecord::Migration
  def change
  	create_table :stations do |t|
      t.integer :station_id
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :dpcapacity
      t.integer :landmark
      t.datetime :online_date

      t.timestamps
    end
  end
end
