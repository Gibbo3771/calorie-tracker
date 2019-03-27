require_relative './application_controller'
require_relative '../models/calorie_intake'
require_relative '../models/food'
require_relative '../models/profile'

class CalorieIntakesController < ApplicationController

    get('/:id') do
        @profile = Profile.find(params['id'])
        @foods = Food.all()
        @calorie_intakes = @profile.get_calorie_intakes()
        erb(:"calorie_intakes/view")
    end

    post('/') do
        puts params
        CalorieIntake.new(params).save()
        Food.new(params).save()
        redirect("/calories/#{params['profile_id']}")
    end

    delete('/') do
        CalorieIntake.delete_most_recent()
        redirect("/calories/#{params['id']}")
    end

end