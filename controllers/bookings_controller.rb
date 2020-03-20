require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/booking.rb' )
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/trainer.rb')
also_reload( '../models/*' )

get "/bookings" do
    @bookings = Booking.all()
  erb (:"bookings/index")
end

post "/bookings" do
  booking = Booking.new(params)
  booking.save()
  redirect to("/bookings")
end

get "/bookings/new" do
  erb (:"bookings/new")
end

post "/bookings/:id" do
  booking = Booking.new(params)
  booking.update()
  redirect to("/bookings")
end

get "/bookings/:id/update" do
  @booking = Booking.find(params[:id].to_i)
  erb (:"bookings/edit")
end

post "/bookings/:id/delete" do
  Booking.delete(params[:id])
  redirect to ("/bookings")
end

get "/bookings/:id" do
  @booking = Booking.find(params[:id].to_i)
  erb (:"bookings/show")
end
