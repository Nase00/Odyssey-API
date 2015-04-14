class Trip < ActiveRecord::Base
	# include ActionView::Helpers::DateHelper

  validates :trip_id,
						:start_time,
						:stop_time,
						:bike_id,
						:origin_station_id,
						:destination_station_id,
						presence: true

	validates :trip_id,
						:bike_id,
						:origin_station_id,
						:destination_station_id,
						numericality: { only_integer: true }

	def duration
		distance_of_time_in_words(self.trip_duration)
	end		
end
