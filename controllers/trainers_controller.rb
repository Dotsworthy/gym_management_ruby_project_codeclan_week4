require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/trainer.rb' )
also_reload( '../models/*' )


get "/trainers" do
  @trainers = Trainer.all()
  erb (:"trainers/index")
end

get "/trainers/:id" do
    @trainer = Trainer.find(params[:id].to_i)
    erb(:"trainers/show")
end
