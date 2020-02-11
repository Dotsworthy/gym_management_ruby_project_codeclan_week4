require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/trainer.rb' )
also_reload( '../models/*' )


get "/trainers" do
  @trainers = Trainer.all()
  erb (:"trainers/index")
end

post "/trainers" do
  trainer = Trainer.new(params)
  trainer.save()
  redirect to("/trainers")
end

get "/trainers/new" do
  erb(:"trainers/new")
end

post "/trainers/:id" do
  trainer = Trainer.new(params)
  trainer.update()
  redirect to("/trainers")
end

get "/trainers/:id/update" do
  @trainer = Trainer.find(params[:id].to_i)
  erb (:"trainers/edit")
end

get "/trainers/:id" do
    @trainer = Trainer.find(params[:id].to_i)
    erb(:"trainers/show")
end
