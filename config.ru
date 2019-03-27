require './app/controllers/application_controller'
require './app/controllers/profiles_controller'
require './app/controllers/food_logs_controller'


map('/profile') { run ProfilesController }
map('/track') { run FoodLogsController }

run ApplicationController