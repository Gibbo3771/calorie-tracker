require './app/controllers/application_controller'
require './app/controllers/profiles_controller'
require './app/controllers/food_logs_controller'
require './app/controllers/sessions_controller'


map('/profile') { run ProfilesController }
map('/track') { run FoodLogsController }
map('/session') { run SessionsController }

run ApplicationController