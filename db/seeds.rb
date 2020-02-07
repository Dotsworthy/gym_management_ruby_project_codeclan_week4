require_relative( "../models/member.rb" )
require_relative( "../models/session.rb" )
require_relative( "../models/booking.rb" )
require("pry-byebug")

member1 = Member.new({
  "first_name" => "Dwayne",
  "last_name" => "Johnson"
  })

member2 = Member.new({
  "first_name" => "Steve",
  "last_name" => "Austin"
  })

binding.pry
nil
