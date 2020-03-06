require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/bookings_controller")
require_relative("controllers/members_controller")
require_relative("controllers/sessions_controller")
require_relative("controllers/trainers_controller")
require_relative("models/calendar.rb")
also_reload( '../models/*' )

require("calendar_helper")

helpers do
  include CalendarHelper
end


get "/" do
  erb(:landing_page, :layout => :layout_splash )
end

get "/index" do
  erb(:index)
end
