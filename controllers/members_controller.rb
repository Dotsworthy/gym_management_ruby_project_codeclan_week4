require( 'sinatra' )
require( 'sinatra/contrib/all' )
include FileUtils::Verbose
require_relative( '../models/member.rb' )
also_reload( '../models/*' )

get "/members" do
  if params[:name_query]
    @members = Member.search(params[:name_query])
  else
    @members = Member.all()
  end
  erb (:"members/index")
end

post "/members" do
  member = Member.new(params)
  member.save()
  redirect to("/members")
end

post '/members/:id/upload-image' do
    tempfile = params[:file][:tempfile]
    filename = params[:file][:filename]
    cp(tempfile.path, "public/images/#{filename}")
    member = Member.find(params[:id])
    member.image_change(filename)
    member.update()
    redirect("/members/#{params[:id]}")
end

get "/members/new" do
  erb(:"members/new")
end

post "/members/:id" do
  member = Member.new(params)
  member.update()
  redirect to("/members")
end



get "/members/:id/update" do
  @member = Member.find(params[:id].to_i)
  erb (:"members/edit")
end

post "/members/:id/delete" do
  Member.delete(params[:id])
  redirect to ("/members")
end

get "/members/:id" do
    @members = Member.all()
    @member = Member.find(params[:id].to_i)
    erb(:"members/show")
end
