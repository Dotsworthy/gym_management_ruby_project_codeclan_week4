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

  def update()
    sql = "
      UPDATE sessions SET
      name = $1
      WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  def self.delete(id)
    sql = "DELETE FROM sessions WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM sessions"
    results = SqlRunner.run(sql)
    return results.map { |session| Session.new(session) }
  end

  def self.delete_all()
    sql = "DELETE FROM sessions"
    SqlRunner.run( sql )
  end

  def self.find(id)
    sql = "SELECT * FROM sessions WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Session.new(result.first)
  end
end
