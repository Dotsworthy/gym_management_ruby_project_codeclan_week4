require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/session.rb')
require_relative('../models/booking.rb')
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

post "/sessions/:id" do
  session = Session.new(params)
  session.update()
  redirect to("/sessions")
end

get "/sessions/:id" do
  @session = Session.find(params[:id].to_i)
  erb (:"sessions/show")
end

post "/sessions/:id/delete" do
  Session.delete(params[:id])
  redirect to ("/sessions")
end

get "/sessions/:id/update" do
  @session = Session.find(params[:id].to_i)
  erb (:"sessions/edit")
end

get "/sessions/:id/bookings" do
  @bookings = Session.find_bookings(params[:id].to_i)
  erb (:"sessions/bookings")
end
