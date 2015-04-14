class Trip < ActiveRecord::Migration
	# include ActionView::Helpers::DateHelper

  def change
  	create_table :trips do |t|
  		t.integer :trip_id
  		t.time :start_time
  		t.time :stop_time
  		t.integer :bike_id
  		t.integer :trip_duration
  		t.integer :origin_station_id
  		t.string :origin_station_name
  		t.integer :destination_station_id
  		t.string :destination_station_name
  		t.string :user_type
  		t.string :gender
  		t.integer :birthday
  	end
  end
end
