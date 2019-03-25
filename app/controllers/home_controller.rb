require_relative './application_controller'

class HomeController < ApplicationController

    get('/:id') do
        @profile = Profile.find(params['id'])
        erb(:"home/view")
    end

end