require_relative( '../db/sql_runner' )

class Member

  attr_reader :id, :first_name, :last_name, :user_name, :image_url

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @user_name = options['user_name']
    @image_url = options['image_url']
  end

  def save()
    sql = "INSERT INTO members
      (
      first_name,
      last_name,
      user_name,
      image_url
      )
      VALUES
      (
        $1, $2, $3, $4
      )
      RETURNING id"
    values = [@first_name, @last_name, @user_name, @image_url]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "
      UPDATE members SET (
      first_name,
      last_name,
      user_name,
      image_url
      ) =
      (
      $1, $2, $3, $4
      )
      WHERE id = $5"
    values = [@first_name, @last_name, @user_name, @image_url, @id]
    SqlRunner.run(sql,values)
  end

  def pretty_name()
    return "#{@first_name} #{@last_name}"
  end

  def self.delete(id)
    sql = "DELETE FROM members WHERE id = $1"
    values = [id]
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
    return Member.new(result.first)
  end

end
