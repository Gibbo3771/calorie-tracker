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
        @food_name = options['food_name'].capitalize()
    end

    def save()
        return find_by_name() if exists?()
        sql = "INSERT INTO #{self.class.table} (
            food_name
            ) VALUES (
             $1   
            ) RETURNING id"
        @id = (SqlRunner.run(sql, [@food_name]).map {|i| i['id']}).first()
        return self
    end

    private

    def exists?()
        sql = "SELECT COUNT(*) AS total FROM #{self.class.table}
        WHERE food_name = $1"
        (SqlRunner.run(sql, [@food_name]).map {|data| data['total']}).first().to_i > 0
    end

    def find_by_name()
        sql = "SELECT * FROM #{self.class.table}
        WHERE food_name = $1"
        return SqlRunner.run(sql, [@food_name]).map { |data| self.class.create_instance(data)}.first()
    end

end