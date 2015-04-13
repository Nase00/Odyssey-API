class Station < ActiveRecord::Base
	validates :station_id,
						:name,
						:latitude,
						:longitude,
						presence: true

	validates :station_id,
						:name,
						uniqueness: true			
end