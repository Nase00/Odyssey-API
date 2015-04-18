get '/trip_for/:bike_id/after/:offset' do
	if trip.nil? && params[:offset] == "0"
		hash = {
			status: 404,
			message: "Bike not found"
		}
	elsif trip.nil?
		hash = {
			status: 510,
			message: "End of the line"
		}
	else
		origin_station = Station.find_by(station_id: trip.origin_station_id)
		destination_station = Station.find_by(station_id: trip.destination_station_id)

		hash = {
			status: 200,
			lat: origin_station.latitude,
			lng: origin_station.longitude,
			trip_id: trip.trip_id,
			start_time: trip.start_time,
			stop_time: trip.stop_time,
			duration: trip.duration,
			start_location: origin_station.name,
			stop_location: destination_station.name
		}
	end
	json(hash)
end