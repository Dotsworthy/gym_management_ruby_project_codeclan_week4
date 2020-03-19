require("sinatra")
require("sinatra/contrib/all")
require('date')
require_relative("controllers/bookings_controller")
require_relative("controllers/members_controller")
require_relative("controllers/sessions_controller")
require_relative("controllers/trainers_controller")
also_reload( '../models/*' )


get "/" do
  erb(:landing_page, :layout => :layout_splash )
end

error 404 do
  @message = "404: We couldn't find that page!"
end

get "/index" do
  day = Date.today.strftime('%d')
  @sessions = Session.find_all_for_day_of_week(day)
  erb(:index)
end
