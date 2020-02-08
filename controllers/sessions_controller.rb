require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/session.rb' )
also_reload( '../models/*' )

get "/sessions" do
  @sessions = Session.all()
  erb(:"sessions/index")
end

post "/sessions" do
  session = Session.new(params)
  session.save()
  redirect to("/sessions")
end

get "/sessions/new" do
  erb (:"sessions/new")
end

get "/sessions/:id" do
  @session = Session.find(params[:id].to_i)
  erb (:"sessions/show")
end
