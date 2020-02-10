require_relative( "../models/member.rb" )
require_relative( "../models/session.rb" )
require_relative( "../models/booking.rb" )
require("pry-byebug")

Booking.delete_all()
Member.delete_all()
Session.delete_all()

# Members
member1 = Member.new({
  "first_name" => "Dwayne",
  "last_name" => "Johnson",
  "alias" => "The Rock",
  "image_url" => "/public/images/1"
  })
member1.save()

member2 = Member.new({
  "first_name" => "Steve",
  "last_name" => "Austin",
  "alias" => "Stone Cold",
  "image_url" => "/public/images/2"
  })
member2.save()

member3 = Member.new({
  "first_name" => "Paul",
  "last_name" => "Lavesque",
  "alias" => "Triple H",
  "image_url" => "/public/images/3"
  })
member3.save()

member4 = Member.new({
  "first_name" => "Shawn",
  "last_name" => "Michaels",
  "alias" => "/public/images/4",
  "image_url" => "/public/images/4"
  })
member4.save()

# Sessions
session1 = Session.new({
  "type" => "Suplexes",
  "starts_at" => "09:00",
  "on_date" => "2020-02-10",
  "duration" => "1",
  "capacity" => "3"
  })
session1.save()

session2 = Session.new({
  "type" => "Suplexes",
  "starts_at" => "14:00",
  "on_date" => "2020-02-10",
  "duration" => "1",
  "capacity" => "3"
  })
session2.save()

session3 = Session.new({
  "type" => "Elbow Drops",
  "starts_at" => "10:00",
  "on_date" => "2020-02-14",
  "duration" => "1",
  "capacity" => "2"
  })
session3.save()

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

binding.pry()
nil
