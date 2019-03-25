require './app/controllers/welcome_controller'
require './app/controllers/profiles_controller'
require './app/controllers/calorie_intakes_controller'

map('/welcome') { run WelcomeController }
map('/profile') { run ProfilesController }
map('/calories') { run CalorieIntakesController }

run ApplicationController