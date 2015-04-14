get '/trip_for/:bike_id/after/:offset' do
	if trip.nil? && params[:offset] == 0.to_s
		{
			status: 404,
			message: "Bike not found"
		}.to_json
	elsif trip.nil?
		{
			status: 510,
			message: "End of the line"
		}.to_json
	else
		origin_station = Station.find_by(station_id: trip.origin_station_id)
		destination_station = Station.find_by(station_id: trip.destination_station_id)

		{
			lat: origin_station.latitude,
			long: origin_station.longitude,
			trip_id: trip.trip_id,
			start_time: trip.start_time,
			stop_time: trip.stop_time,
			duration: trip.duration,
			start_location: origin_station.name,
			stop_location: destination_station.name
		}.to_json
	end
end