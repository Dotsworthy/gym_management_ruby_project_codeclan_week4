require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/booking.rb')
require_relative('../models/trainer.rb')

get "/sessions" do
  @sessions = Session.available_sessions()
  erb(:"sessions/index")
end

get "/sessions/all" do
  @sessions = Session.all()
  erb(:"sessions/index")
end

get "/sessions/past" do
  @sessions = Session.past_sessions()
  erb(:"sessions/past")
end

post "/sessions" do
  session = Session.new(params)
  session.save()
  Session.multiple_weeks(session, params[:recurring].to_i)
  redirect to("/sessions")
end

get "/sessions/new" do
  @trainers = Trainer.all()
  erb(:"sessions/new")
end

post "/sessions/:id" do
  session = Session.new(params)
  session.update()
  redirect to("/sessions")
end

get "index" do
  @sessions = Session.available_sessions()
end

get "/sessions/upcoming" do
  @sessions = Session.available_sessions()
  erb(:"sessions/index")
end

get "/sessions/:id" do
  @session = Session.find(params[:id].to_i)
  @trainer = @session.find_trainer()
  @members_signed_up = @session.find_members_signed_up()
  erb(:"sessions/show")
end

post "/sessions/:id/delete" do
  Session.delete(params[:id])
  redirect to ("/sessions")
end

get "/sessions/:id/update" do
  @session = Session.find(params[:id].to_i)
  @trainers= Trainer.all()
  @trainer = @session.find_trainer()
  erb(:"sessions/edit")
end

get "/sessions/:id/bookings" do
  @session = Session.find(params[:id].to_i)
  @bookings = Session.find_bookings(params[:id].to_i)
  erb(:"sessions/bookings")
end

get "/sessions/filtered-by-day/:day" do
  @sessions = Session.find_upcoming_for_day_of_week(params[:day])
  erb(:"sessions/index")
end
