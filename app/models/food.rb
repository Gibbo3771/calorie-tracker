require_relative './model'

class Food < Model
    class << self

        def table
            "foods"
        end

        def create_instance(options)
            return Food.new(options)
        end        
    end

    attr_accessor :name
    def set_data(options)
        super
        @food_name = options['food_name']
    end

    def save()
        cap = @food_name.capitalize()
        return if exists?(cap)
        sql = "INSERT INTO #{self.class.table} (
            food_name
            ) VALUES (
             $1   
            ) RETURNING id"
        @id = SqlRunner.run(sql, [cap]).map {|i| i['id']}
        return
    end

    private

    def exists?(food_name)
        sql = "SELECT COUNT(*) AS total FROM #{self.class.table}
        WHERE food_name = $1"
        (SqlRunner.run(sql, [food_name]).map {|data| data['total']}).first().to_i > 0
    end

end