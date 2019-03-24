require './app/controllers/welcome_controller'
require './app/controllers/profiles_controller'

map('/welcome') { run WelcomeController }
map('/profile') { run ProfilesController }

run ApplicationController