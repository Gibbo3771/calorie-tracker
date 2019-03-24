require_relative '../../db/sql_runner'

class Model

    attr_reader :id, :table
    def initialize(options, table="SCHEMA NOT SET")
        @table = table
        set_data(options)
    end

    protected

    def self.create_instance(options)
        # stub method
    end

    def set_data(options)
        @id = options['id'] if options['id']
    end

    public

    def delete()
        sql = "DELETE FROM #{@table}
        WHERE id = $1"
        puts sql
        return SqlRunner.run(sql, [@id])
    end

    def self.delete_all(table="SCHEME NOT SET")
        sql = "DELETE FROM #{table}"
        return SqlRunner.run(sql,)
    end

    def self.find(id, table="SCHEME NOT SET")
        sql = "SELECT * FROM #{table}
        WHERE id = $1"
        return SqlRunner.run(sql, [id]).map { |data| create_instance(data)}.first()
    end


    def self.all(table="SCHEME NOT SET")
        sql = "SELECT * FROM #{table}"
        return SqlRunner.run(sql).map { |data| self.create_instance(data)}
    end

end