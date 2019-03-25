require './app/controllers/application_controller'
require './app/controllers/profiles_controller'
require './app/controllers/calorie_intakes_controller'


map('/profile') { run ProfilesController }
map('/calories') { run CalorieIntakesController }

run ApplicationController