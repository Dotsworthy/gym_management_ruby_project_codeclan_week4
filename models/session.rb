require('time')
require('date')
require('pry-byebug')
require_relative( '../db/sql_runner' )


class Session

  attr_reader :id, :type, :starts_at, :led_by, :num_of_places
  attr_accessor :on_date

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @type = options['type']
    @starts_at = options['starts_at']
    @on_date = options['on_date']
    @led_by = options['led_by']
    @num_of_places = options['num_of_places']
  end

  def save()
    sql = "INSERT INTO sessions
      (
      type,
      starts_at,
      on_date,
      led_by,
      num_of_places
      )
      VALUES
      (
        $1, $2, $3, $4, $5
      )
      RETURNING id"
    values = [@type, @starts_at, @on_date, @led_by, @num_of_places]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "
      UPDATE sessions SET (
      type,
      starts_at,
      on_date,
      led_by,
      num_of_places
      )
      = (
      $1, $2, $3, $4, $5
      )
      WHERE id = $6"
    values = [@type, @starts_at, @on_date, @led_by, @num_of_places, @id]
    SqlRunner.run(sql,values)
  end

  def date_check()
    time = Time.parse("#{@on_date} #{@starts_at}")
    return time > Time.now
  end

  def find_trainer()
    sql = "Select * From trainers INNER JOIN sessions on sessions.led_by = trainers.id WHERE sessions.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return Trainer.new(result.first)
  end

  def self.find_all_for_day_of_week(day)
    sessions = Session.all()
    return sessions.filter {|session| Date.parse(session.on_date).strftime('%A').downcase() == day}
  end

  def self.find_upcoming_for_day_of_week(day)
    sessions = Session.available_sessions()
    return sessions.filter {|session| Date.parse(session.on_date).strftime('%A').downcase() == day}
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
  #
  def find_members_signed_up()
    sql = "SELECT members.* FROM members INNER JOIN bookings ON bookings.member_id = members.id WHERE bookings.session_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |member| Member.new(member) }
  end

  def self.available_sessions()
    sql = "SELECT * FROM sessions"
    values = SqlRunner.run(sql)
    all_sessions = values.map { |session| Session.new(session)}
    return result = all_sessions.filter { |session| session.date_check}
  end

  def self.past_sessions()
    sql = "SELECT * FROM sessions"
    values = SqlRunner.run(sql)
    all_sessions = values.map { |session| Session.new(session)}
    return result = all_sessions.reject { |session| session.date_check}
  end

  def self.multiple_weeks(session, weeks)
    return if weeks < 0
    repeating_session = Session.find(session.id)
    while weeks > 0
      new_date = Date.parse(repeating_session.on_date)
      new_date += 7
      repeating_session.on_date = new_date.to_s()
      repeating_session.save()
      weeks -= 1
    end
  end
end
