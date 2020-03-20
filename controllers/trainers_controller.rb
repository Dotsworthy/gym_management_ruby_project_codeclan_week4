require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/trainer.rb' )
also_reload( '../models/*' )


get "/trainers" do
  if params[:name_query]
    @trainers = Trainer.search(params[:name_query])
  else
    @trainers = Trainer.all()
  end
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

post '/trainers/:id/upload-image' do
    tempfile = params[:file][:tempfile]
    filename = params[:file][:filename]
    cp(tempfile.path, "public/images/#{filename}")
    trainer = Trainer.find(params[:id])
    trainer.image_change(filename)
    trainer.update()
    redirect("/trainers/#{params[:id]}")
end

post "/trainers/:id/delete" do
  Trainer.delete(params[:id])
  redirect to ("/trainers")
end


get "/trainers/:id/update" do
  @trainer = Trainer.find(params[:id].to_i)
  erb (:"trainers/edit")
end

get "/trainers/:id" do
    @trainer = Trainer.find(params[:id].to_i)
    erb(:"trainers/show")
end
