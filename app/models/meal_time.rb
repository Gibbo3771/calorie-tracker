require_relative './model'

class MealTime < Model
    class << self

        def table
            "meal_times"
        end

        def create_instance(options)
            return MealTime.new(options)
        end

    end


    protected

    def set_data(options)
        super
        @meal_name = options['meal_name']
    end

end