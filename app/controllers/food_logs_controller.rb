require_relative './application_controller'
require_relative '../models/food_log'
require_relative '../models/food'
require_relative '../models/profile'

class FoodLogsController < ApplicationController

    get('/:id') do
        @profile = Profile.find(params['id'])
        @foods = Food.all()
        @food_log = @profile.get_food_log_today()
        erb(:"track/view")
    end

    post('/') do
        food = Food.new(params)
        food = food.save()
        puts "food id #{food.id}"
        params['food_id'] = food.id
        puts params
        FoodLog.new(params).save()
        redirect("/track/#{params['profile_id']}")
    end

    delete('/') do
        FoodLog.delete_most_recent()
        redirect("/track/#{params['id']}")
    end

end