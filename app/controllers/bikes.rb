get '/bike_for/:trip_id' do
	trip = Trip.find_by(trip_id: params[:trip_id].to_i)

	trip ? trip.bike_id.to_json : "Not found.".to_json
end