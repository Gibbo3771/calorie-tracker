require_relative './application_controller'
require_relative '../models/calorie_intake'

class CalorieIntakesController < ApplicationController

    get('/:id') do
        @profile = Profile.find(params['id'])
        erb(:"calorie_intakes/view")
    end

    post('/') do
        CalorieIntake.new(params).save()
        redirect("/calories/#{params['profile_id']}")
    end

    delete('/') do
        CalorieIntake.delete_most_recent()
        redirect("/calories/#{params['id']}")
    end

end