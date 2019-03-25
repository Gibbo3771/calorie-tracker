require 'pathname'
require 'fileutils'
require 'json'

require 'rake/testtask'

task :default => ["db:reset"]

namespace :set do
    desc('Sets up the application for development')
    task :dev do
        set_dev_mode(true)
    end
    desc('Sets up the application for production')
    task :production do
        set_dev_mode(false)
    end
end

namespace :db do
    desc('Drops the database')
    task :drop do
        drop_database()
    end
    desc('Seeds the database with testing data')
    task :seed do
        seed()
    end
    desc('Creates the database and schema')
    task :load_schema do
        create_database()
        create_tables()
    end
    desc('Recreate the database and schemas, then seed the database')
    task :reset do
        drop_database()
        create_database()
        create_tables()
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




