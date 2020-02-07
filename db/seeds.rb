require_relative( "../models/member.rb" )
require_relative( "../models/session.rb" )
require_relative( "../models/booking.rb" )
require("pry-byebug")

Member.delete_all()

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

binding.pry
nil
