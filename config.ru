require './app/controllers/welcome_controller'
require './app/controllers/profiles_controller'
require './app/controllers/home_controller'

map('/welcome') { run WelcomeController }
map('/profile') { run ProfilesController }
map('/home') { run HomeController }

run ApplicationController