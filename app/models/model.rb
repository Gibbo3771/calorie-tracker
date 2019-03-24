require_relative '../../db/sql_runner'

class Model
    class << self

        def delete_all()
            sql = "DELETE FROM #{table}"
            return SqlRunner.run(sql)
        end
    
        def find(id)
            sql = "SELECT * FROM #{table}
            WHERE id = $1"
            return SqlRunner.run(sql, [id]).map { |data| create_instance(data)}.first()
        end
    
        def all()
            sql = "SELECT * FROM #{table}"
            return SqlRunner.run(sql).map { |data| self.create_instance(data)}
        end

        protected
        
        def create_instance(options)
            raise NotImplementedError
        end

        def table
            raise NotImplementedError
        end

    end

    attr_reader :id, :table
    def initialize(options)
        set_data(options)
    end

    protected

    def set_data(options)
        @id = options['id'] if options['id']
    end

    public

    def delete()
        sql = "DELETE FROM #{self.class.table}
        WHERE id = $1"
        puts sql
        return SqlRunner.run(sql, [@id])
    end

end