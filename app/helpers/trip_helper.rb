helpers do
	def next_trip_params
		params[:offset].to_i
	end

	def trip
		Trip.where(bike_id: params[:bike_id].to_i)
				.offset(next_trip_params)
				.limit(1)
				.order(start_time: :asc)
				.first
	end

	def time_in_words(seconds)
		mm, ss = seconds.divmod(60)
		"%d minutes, %d seconds" % [mm, ss]
	end
end