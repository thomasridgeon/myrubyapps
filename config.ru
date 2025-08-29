require 'bundler'
Bundler.require

require 'dotenv/load'

require_relative 'controllers/homepage_controller'
require_relative 'views/homepage_view'
require_relative 'controllers/aboutme_controller'
require_relative 'views/aboutme_view'
require_relative 'controllers/projects_controller'
require_relative 'views/projects_view'
require_relative 'controllers/resume_controller'
require_relative 'views/resume_view'
require_relative 'controllers/sunbenefits_controller'
require_relative 'views/sunbenefits_view'
require_relative 'controllers/portcharges_controller'
require_relative 'views/portcharges_view'
require_relative 'controllers/solardcalculator_controller'
require_relative 'views/solardcalculator_view'

configure :development do
  require 'sinatra/reloader'
  register Sinatra::Reloader
  require 'pry-byebug'
end

run Sinatra::Application
