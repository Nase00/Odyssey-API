get '/trip_for/:bike_id/after/:offset' do
	origin_station = Station.find_by(station_id: trip.origin_station_id)
	destination_station = Station.find_by(station_id: trip.destination_station_id)

	hash = {
		lat: origin_station.latitude,
		long: origin_station.longitude,
		trip_id: trip.trip_id,
		start_time: trip.start_time,
		stop_time: trip.stop_time,
		duration: trip.duration,
		start_location: origin_station.name,
		stop_location: destination_station.name
	}

	hash.to_json
end