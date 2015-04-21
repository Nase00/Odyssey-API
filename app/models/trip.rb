class Trip < ActiveRecord::Base
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
		self.trip_duration
	end

	def start_time
		super.strftime("%I:%M%P on %-m/%-d/%y")
	end

	def stop_time
		super.strftime("%I:%M%P on %-m/%-d/%y")
	end
end
