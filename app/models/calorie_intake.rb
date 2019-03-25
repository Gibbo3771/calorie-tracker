require_relative './model'

class CalorieIntake < Model
    class << self

        def table
            "calorie_intakes"
        end

        def create_instance(options)
            return Profile.new(options)
        end
        
    end

    protected
    
    attr_accessor :profile_id, :calories, :datestamp
    def set_data(options)
        super
        @profile_id = options['profile_id']
        @calories = options['calories']
        @datestamp = options['datestamp']
    end

end