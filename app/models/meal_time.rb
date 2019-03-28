require_relative './model'

class MealTime < Model
    class << self

        def table
            "meal_times"
        end

        def create_instance(options)
            return MealTime.new(options)
        end

        def find_by_name(name)
            sql = "SELECT * FROM #{table}
            WHERE meal_name = $1"
            return SqlRunner.run(sql, [name]).map { |data| create_instance(data)}.first()
        end

    end

    attr_accessor :meal_name

    protected

    def set_data(options)
        super
        @meal_name = options['meal_name']
    end

end