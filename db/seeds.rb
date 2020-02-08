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
  "last_name" => "Johnson"
  })
member1.save()

member2 = Member.new({
  "first_name" => "Steve",
  "last_name" => "Austin"
  })
member2.save()

member3 = Member.new({
  "first_name" => "Paul",
  "last_name" => "Lavesque"
  })
member3.save()

member4 = Member.new({
  "first_name" => "Shawn",
  "last_name" => "Michaels"
  })
member4.save()

# Sessions
session1 = Session.new({
  "name" => "Suplexes"
  })
session1.save()

session2 = Session.new({
  "name" => "Elbow Drops"
  })
session2.save()

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
