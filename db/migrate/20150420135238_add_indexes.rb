class AddIndexes < ActiveRecord::Migration
  def change
  	add_index :trips, [:start_time, :trip_id]
  	add_index :stations, :station_id
  end
end
