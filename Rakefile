require 'pathname'
require 'fileutils'
require 'json'

require 'rake/testtask'

task :default => ["production:setup"]

desc('Configures the application to run in production mode')
namespace :production do
    desc('Drops and creates the database for the application')
    task :setup do 
        drop_database()
        create_database()
        create_tables()
        set_dev_mode(false)
        puts "-- PRODUCTION ENVIRONMENT SETUP --\n"
        puts "-- Start server with start_app --\n"
    end
end

desc('Configures the application to run in developer mode')
namespace :dev do
    desc('Creates the db setup for testing')
    task :setup do
        puts "\n-- SETTING UP TESTING ENVIRONMENT --"
        drop_database()
        create_database()
        create_tables()
        set_dev_mode(true)
        puts "-- TESTING ENVIRONMENT SETUP --\n"
    end
    desc('Populates the db with dummy data')
    task :dummy_data do
        puts "-- POPULATING DATABASE WITH DUMMY DATA --\n"
        sh %{psql -d calorie_tracker -f ./db/john_doe.sql > /dev/null}, verbose: false
    end
    desc('Purges the database of all data')
    task :purge do
        purge_database()
        create_tables()
    end
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




