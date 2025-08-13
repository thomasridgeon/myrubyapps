#gem install sinatra
#gem install sinatra-reloader
require "sinatra"
require "erector"
require 'sinatra/reloader'
configure :development do
  register Sinatra::Reloader
end
#
RATES = {
  "fas" => {
    "20ST" => 1221.98
    "40ST" => 2443.96
    "40HC" => 2661.32
    "20RH" => 1328.93
    "40RH" => 2657.85
  },
  "security_fee" => {
    "20ST" => 155.10
    "40ST" => 310.20
    "40HC" => 310.20
    "20RH" => 105.75
    "40RH" => 211.50
},
"hazard" => {
  "20ST" => 118.68
  "40ST" => 259.09
  "40HC" => 259.09

},
"unstuffing" => {
  "20ST" => 528.75
  "40ST" => 1075.50
  "40HC" => 1075.50

},
"plugs_daily_rate" => {
  "20RH" => 115.15
  "40RH" => 230.30
}
}
#In Ruby, => is a special operator most commonly used to define key-value pairs within a hash. It separates the key from its corresponding value.
#the curly braces {} are used to define a hash. A hash is a fundamental data structure in Ruby that stores data in key-value pairs. It's a perfect way to organize and look up information.
