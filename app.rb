require("sinatra")
require("sinatra/contrib/all")
require('date')
require_relative("controllers/bookings_controller")
require_relative("controllers/members_controller")
require_relative("controllers/sessions_controller")
require_relative("controllers/trainers_controller")
require_relative("db/seeds")
also_reload( '../models/*' )


get "/" do
  Booking.delete_all()
  Session.delete_all()
  Member.delete_all()
  Trainer.delete_all()

  # Members
  member1 = Member.new({
    "first_name" => "Dwayne",
    "last_name" => "Johnson",
    "user_name" => "The Rock",
    "image_url" => "1.jpg"
    })
  member1.save()

  member2 = Member.new({
    "first_name" => "Steve",
    "last_name" => "Austin",
    "user_name" => "Stone Cold",
    "image_url" => "2.jpg"
    })
  member2.save()

  member3 = Member.new({
    "first_name" => "Paul",
    "last_name" => "Lavesque",
    "user_name" => "Triple H",
    "image_url" => "3.jpg"
    })
  member3.save()

  member4 = Member.new({
    "first_name" => "Shawn",
    "last_name" => "Michaels",
    "user_name" => "The Heartbreak Kid",
    "image_url" => "4.jpeg"
    })
  member4.save()

  trainer1 = Trainer.new({
    "first_name" => "Randy",
    "last_name" => "Savage",
    "user_name" => "Macho Man",
    "image_url" => "5.jpg"
    })
  trainer1.save()

  trainer2 = Trainer.new({
    "first_name" => "Ric",
    "last_name" => "Flair",
    "user_name" => "Nature Boy",
    "image_url" => "6.jpg"
    })
  trainer2.save()

  trainer3 = Trainer.new({
    "first_name" => "Hulk",
    "last_name" => "Hogan",
    "user_name" => "Hulkamaniac",
    "image_url" => "7.jpg"
    })
  trainer3.save()

  # Sessions
  day1 = Date.today()
  session1 = Session.new({
    "type" => "Suplexes",
    "starts_at" => "09:00",
    "on_date" => day1.strftime('%Y-%B-%d'),
    "led_by" => trainer3.id,
    "num_of_places" => "2"
    })
  session1.save()

  day2 = Date.today + 1
  session2 = Session.new({
    "type" => "Suplexes",
    "starts_at" => "10:00",
    "on_date" => day2.strftime('%Y-%B-%d'),
    "led_by" => trainer2.id,
    "num_of_places" => "2"
    })
  session2.save()

  day3 = Date.today + 2
  session3 = Session.new({
    "type" => "Elbow Drops",
    "starts_at" => "11:00",
    "on_date" => day3.strftime('%Y-%B-%d'),
    "led_by" => trainer1.id,
    "num_of_places" => "2"
    })
  session3.save()

  day4 = Date.today + 3
  session4 = Session.new({
    "type" => "Mic Work",
    "starts_at" => "12:00",
    "on_date" => day4.strftime('%Y-%B-%d'),
    "led_by" => trainer2.id,
    "num_of_places" => "2"
    })
  session4.save()

  day5 = Date.today + 4
  session5 = Session.new({
    "type" => "Submissions",
    "starts_at" => "14:00",
    "on_date" => day5.strftime('%Y-%B-%d'),
    "led_by" => trainer1.id,
    "num_of_places" => "2"
    })
  session5.save()

  day6 = Date.today + 5
  session6 = Session.new({
    "type" => "Leg Drops",
    "starts_at" => "15:00",
    "on_date" => day6.strftime('%Y-%B-%d'),
    "led_by" => trainer3.id,
    "num_of_places" => "2"
    })
  session6.save()

  day7 = Date.today + 6
  session7 = Session.new({
    "type" => "Taunting",
    "starts_at" => "16:00",
    "on_date" => day7.strftime('%Y-%B-%d'),
    "led_by" => trainer2.id,
    "num_of_places" => "2"
    })
  session7.save()

  day8 = Date.today + 7
  session8 = Session.new({
    "type" => "Suplexes",
    "starts_at" => "17:00",
    "on_date" => day8.strftime('%Y-%B-%d'),
    "led_by" => trainer1.id,
    "num_of_places" => "2"
    })
  session8.save()

  # Bookings
  booking1 = Booking.new({
    "member_id" => member1.id,
    "session_id" => session1.id
    })
  booking1.save()

  booking2 = Booking.new({
    "member_id" => member2.id,
    "session_id" => session2.id
    })
  booking2.save()

  booking3 = Booking.new({
    "member_id" => member3.id,
    "session_id" => session1.id
    })
  booking3.save()
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
