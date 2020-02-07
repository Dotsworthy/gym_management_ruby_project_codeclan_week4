require_relative( '../db/sql_runner' )

class Member

  attr_reader :id, :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO members
      (
      first_name,
      last_name
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
    values = [@first_name, @last_name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "
      UPDATE members SET (
      first_name,
      last_name
      ) =
      (
      $1, $2
      )
      WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run( sql )
  end

  def self.all()
    sql = "SELECT * FROM members"
    results = SqlRunner.run(sql)
    return results.map { |member| Member.new(member) }
  end

  def self.find(id)
    sql = "SELECT * FROM members WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result.map { |member| Member.new(member) }
  end
  
end
