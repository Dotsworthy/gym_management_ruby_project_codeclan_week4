require('time')
require_relative( '../db/sql_runner' )


class Session

  attr_reader :id, :type, :starts_at, :on_date, :duration, :capacity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
    @starts_at = options['starts_at']
    @on_date = options['on_date']
    @duration = options['duration']
    @capacity = options['capacity']
  end

  def save()
    sql = "INSERT INTO sessions
      (
      type,
      starts_at,
      on_date,
      duration,
      capacity
      )
      VALUES
      (
        $1, $2, $3, $4, $5
      )
      RETURNING id"
    values = [@type, @starts_at, @on_date, @duration, @capacity]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "
      UPDATE sessions SET (
      type,
      starts_at,
      on_date,
      duration,
      capacity
      )
      = (
      $1, $2, $3, $4, $5
      )
      WHERE id = $6"
    values = [@type, @starts_at, @on_date, @duration, @capacity, @id]
    SqlRunner.run(sql,values)
  end

  def date_check()
    time = Time.parse("#{@on_date} #{@starts_at}")
    if time < Time.now
      return false
    else
      return true
    end
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

  def self.find_bookings(id)
    sql = "SELECT * FROM sessions INNER JOIN bookings ON bookings.session_id = sessions.id WHERE sessions.id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return results.map { |booking| Booking.new(booking) }
  end

  def self.available_sessions()
    sql = "SELECT * FROM sessions"
    values = SqlRunner.run(sql)
    sessions = values.map { |session| Session.new(session)}
    return result = sessions.map { |session| session if session.date_check == true}
  end


end
