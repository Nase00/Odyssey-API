require 'rake'
require 'csv'
require 'date'

require ::File.expand_path('../config/environment', __FILE__)

# Include all of ActiveSupport's core class extensions, e.g., String#camelize
require 'active_support'
require 'active_support/core_ext'

namespace :generate do
  desc "Create an empty model in app/models, e.g., rake generate:model NAME=User"
  task :model do
    unless ENV.has_key?('NAME')
      raise "Must specificy model name, e.g., rake generate:model NAME=User"
    end

    model_name     = ENV['NAME'].camelize
    model_filename = ENV['NAME'].underscore + '.rb'
    model_path = APP_ROOT.join('app', 'models', model_filename)

    if File.exist?(model_path)
      raise "ERROR: Model file '#{model_path}' already exists"
    end

    puts "Creating #{model_path}"
    File.open(model_path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        class #{model_name} < ActiveRecord::Base
          # Remember to create a migration!
        end
      EOF
    end
  end

  desc "Create an empty migration in db/migrate, e.g., rake generate:migration NAME=create_tasks"
  task :migration do
    unless ENV.has_key?('NAME')
      raise "Must specificy migration name, e.g., rake generate:migration NAME=create_tasks"
    end

    name     = ENV['NAME'].camelize
    filename = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), ENV['NAME'].underscore]
    path     = APP_ROOT.join('db', 'migrate', filename)

    if File.exist?(path)
      raise "ERROR: File '#{path}' already exists"
    end

    puts "Creating #{path}"
    File.open(path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        class #{name} < ActiveRecord::Migration
          def change
          end
        end
      EOF
    end
  end

  desc "Create an empty model spec in spec, e.g., rake generate:spec NAME=user"
  task :spec do
    unless ENV.has_key?('NAME')
      raise "Must specificy migration name, e.g., rake generate:spec NAME=user"
    end

    name     = ENV['NAME'].camelize
    filename = "%s_spec.rb" % ENV['NAME'].underscore
    path     = APP_ROOT.join('spec', filename)

    if File.exist?(path)
      raise "ERROR: File '#{path}' already exists"
    end

    puts "Creating #{path}"
    File.open(path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        require 'spec_helper'
        describe #{name} do
          pending "add some examples to (or delete) #{__FILE__}"
        end
      EOF
    end
  end

end

namespace :db do
  desc "Drop, create, and migrate the database"
  task :reset => [:drop, :create, :migrate]

  desc "Create the databases at #{DB_NAME}"
  task :create do
    puts "Creating development and test databases if they don't exist..."
    system("createdb #{APP_NAME}_development && createdb #{APP_NAME}_test")
  end

  desc "Drop the database at #{DB_NAME}"
  task :drop do
    puts "Dropping development and test databases..."
    system("dropdb #{APP_NAME}_development && dropdb #{APP_NAME}_test")
  end

  desc "Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
  task :migrate do
    ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
      ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
    end
  end

  desc "Populate the database with dummy data by running db/seeds.rb"
  task :seed do
    require APP_ROOT.join('db', 'seeds.rb')
  end

  desc "Returns the current schema version number"
  task :version do
    puts "Current version: #{ActiveRecord::Migrator.current_version}"
  end

  namespace :test do
    desc "Migrate test database"
    task :prepare do
      system "rake db:migrate RACK_ENV=test"
    end
  end
end

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/environment"
end

namespace :pd do
  desc "Fix invalid dates"
  task fixdates: :environment do
    bike_ids = Set.new(1..3000)
    bike_ids.each do |bike_id|
      bike_trips = Trip.where(bike_id: bike_id).to_a
      bike_trips.each do |trip|
        p trip.start_time
        trip.start_time = DateTime.strptime(trip.start_time, "%m/%d/%Y %H:%M")
        trip.stop_time = DateTime.strptime(trip.stop_time, "%m/%d/%Y %H:%M")
        p trip.start_time
        trip.save
      end
    end
  end

  desc "Parse stations data into database"
  task :stations do
    files = [
              File.join("./db/raw/Divvy_Stations_2014-Q1Q2.csv", ),
              File.join("./db/raw/Divvy_Stations_2014-Q3Q4.csv", )
            ]
    files.each do |file|
      CSV.foreach(file, headers: true) do |row|
        Station.create(
          station_id: row["id"].to_i,
          name: row["name"],
          latitude: row["latitude"].to_f,
          longitude: row["longitude"].to_f,
          dpcapacity: row["dpcapacity"].to_i,
          online_date: Date.strptime(row["online_date"], '%m/%d')
        )
      end
    end
  end

  desc "Parse trips data into database"
  task :trips do
    files = [
              File.join("./db/raw/Divvy_Trips_2014-Q1Q2a.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q1Q2a_2.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q1Q2b.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q1Q2b_2.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q1Q2c.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q1Q2c_2.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q1Q2d.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q1Q2d_2.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q3a.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q3a_2.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q3b.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q3b_2.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q3c_2.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q4a.csv"),
              File.join("./db/raw/Divvy_Trips_2014-Q4b.csv")
            ]
    files.each do |file|
      CSV.foreach(file, headers: true) do |row|
        puts "--- Loading from #{file} ---"
        Trip.find_or_create_by(
          trip_id: row["trip_id"].to_i,
          start_time: DateTime.strptime(row["starttime"], "%m/%d/%Y %H:%M"),
          stop_time: DateTime.strptime(row["stoptime"], "%m/%d/%Y %H:%M"),
          bike_id: row["bikeid"].to_i,
          trip_duration: row["tripduration"].to_i,
          origin_station_id: row["from_station_id"].to_i,
          destination_station_id: row["to_station_id"].to_i,
          origin_station_name: row["to_station_name"],
          destination_station_name: row["from_station_name"],
          user_type: row["usertype"],
          gender: row["gender"],
          birthday: row["birthday"].to_i
        )
      end
      puts "=== Completed #{file} ==="
    end
  end
end

task :default  => :spec