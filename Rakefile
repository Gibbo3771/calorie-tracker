require 'pathname'
require 'fileutils'
require 'json'

require 'rake/testtask'

task :default => ["db:dev"]

namespace :db do
    desc('Drops the database')
    task :drop do
        drop_database()
    end
    desc('Seeds the database with data for testing/development')
    task :seed do
        seed()
    end
    desc('Purges the database of all data while keeping the schemas intact')
    task :purge do
        purge_database()
    end
    desc('Reseeds the database with the data for testing/development')
    task :reseed => [:purge, :seed] do
    end
    desc('Creates the database and schema')
    task :load_schema do
        create_database()
        create_tables()
    end
    desc('Sets the database up for development')
    task :dev => [:drop, :load_schema, :seed] do
        set_dev_mode(true)
    end
    desc('Sets the database up for production')
    task :production => [:drop, :load_schema] do
        set_dev_mode(false)
    end
end

def seed()
    puts "-- Seeding database --\n"
    sh %{psql -d calorie_tracker -f ./db/john_doe.sql > /dev/null}, verbose: false
end

def drop_database()
    puts "-- Dropping database --\n"
    sh %{dropdb --if-exists calorie_tracker > /dev/null}, verbose: false
end

def create_database()
    puts "-- Creating new database --\n"
    sh %{createdb calorie_tracker}, verbose: false
end

def create_tables()
    puts "-- Creating tables --"
    sh %{psql -d calorie_tracker -f ./db/setup.sql > /dev/null}, verbose: false
end

def purge_database()
    puts "-- Purging database --\n"
    sh %{psql -d calorie_tracker -f ./db/purge.sql > /dev/null}, verbose: false
end

def set_dev_mode(dev_mode)
    File.open("./config/settings.json","w") { |f|
        f.write({"dev" => dev_mode}.to_json)
    }
end

# Run all tests
Rake::TestTask.new do |t|
    t.test_files = FileList['./spec/**/*_spec.rb']
    end




