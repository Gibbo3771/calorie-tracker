require_relative './model'

class CalorieConsumption < Model

    attr_accessor :profile_id, :calories, :datestamp
    def initialize(options, table="calories_consumed")
        super
    end

    protected
``
    def set_data(options)
        super
        @profile_id = options['profile_id']
        @calories = options['calories']
        @datestamp = options['datestamp']
    end

end