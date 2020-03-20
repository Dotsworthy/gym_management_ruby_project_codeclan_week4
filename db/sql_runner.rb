require( 'pg' )
require('uri')

class SqlRunner

  def self.run( sql, values = [] )
    if ENV["DATABASE_URL"]
      uri = URI.parse(ENV["DATABASE_URL"])
      database_config = {
        host: uri.host,
        dbname: uri.path[1..-1],
        user: uri.user,
        password: uri.password
      }
    else
      database_config = {host: "localhost", dbname: "wrestling_gym"}
    end
    begin
      db = PG.connect(database_config)
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
