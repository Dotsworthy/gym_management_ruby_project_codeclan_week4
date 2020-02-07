require_relative( '../db/sql_runner' )

class Session

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO sessions
      (
      name
      )
      VALUES
      (
        $1
      )
      RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM sessions"
    SqlRunner.run( sql )
  end

end
