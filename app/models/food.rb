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

    attr_accessor :food_name
    def set_data(options)
        super
        @food_name = options['food_name']
    end

    def save()
        puts not_specified()
        return if not_specified()
        cap = @food_name.capitalize()
        return find_by_name(cap) if exists?(cap)
        sql = "INSERT INTO #{self.class.table} (
            food_name
            ) VALUES (
             $1   
            ) RETURNING id"
        @id = (SqlRunner.run(sql, [cap]).map {|i| i['id']}).first()
        puts @id
        return self
    end

    def not_specified()
        return !@name.nil?
    end

    private

    def exists?(food_name)
        sql = "SELECT COUNT(*) AS total FROM #{self.class.table}
        WHERE food_name = $1"
        (SqlRunner.run(sql, [food_name]).map {|data| data['total']}).first().to_i > 0
    end

    def find_by_name(name)
        puts "find by name"
        sql = "SELECT * FROM #{self.class.table}
        WHERE food_name = $1"
        return SqlRunner.run(sql, [name]).map { |data| 
            puts "Data in find by name #{data}"
            self.class.create_instance(data)}.first()
    end

end