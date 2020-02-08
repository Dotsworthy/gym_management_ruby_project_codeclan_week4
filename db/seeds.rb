require_relative( "../models/member.rb" )
require_relative( "../models/session.rb" )
require_relative( "../models/booking.rb" )
require("pry-byebug")

Booking.delete_all()
Member.delete_all()
Session.delete_all()


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

session1 = Session.new({
  "name" => "Suplexes"
  })
session1.save()

session2 = Session.new({
  "name" => "Elbow Drops"
  })
session2.save()

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

binding.pry()
nil
