require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/booking.rb' )
also_reload( '../models/*' )

get "/bookings" do
  @bookings = Booking.all()
  erb(:"bookings/index")
end

get "/bookings/:id" do
  @booking = Booking.find(params[:id].to_i)
  erb (:"bookings/show")
end
