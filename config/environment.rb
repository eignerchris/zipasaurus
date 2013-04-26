require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require :default
require 'pp'

class ZipasaurusApp < Sinatra::Base

  require File.join(File.expand_path(File.dirname(__FILE__)), '../app.rb')
  require File.join(File.expand_path(File.dirname(__FILE__)), '../models/zip.rb')

  configure :development do
    use Rack::ShowExceptions
    DataMapper.setup(:default, 'postgres://eignerchris:@localhost/zipasaurus')
    DataMapper.auto_upgrade!
  end

  configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
    DataMapper.auto_upgrade!
  end
  
  use Rack::CommonLogger
  use Rack::MethodOverride
  use Rack::JSONP

  STATE_ABBREV = { "wyoming"=>"wy", "oregon"=>"or", "missouri"=>"mo", "arkansas"=>"ar", "new jersey"=>"nj", "north carolina"=>"nc", "illinois"=>"il", "indiana"=>"in", "tennessee"=>"tn", "west virginia"=>"wv", "ohio"=>"oh", "oklahoma"=>"ok", "michigan"=>"mi", "mississippi"=>"ms", "arizona"=>"az", "kentucky"=>"ky", "california"=>"ca", "minnesota"=>"mn", "kansas"=>"ks", "district of columbia"=>"dc", "massachusetts"=>"ma", "alaska"=>"ak", "virginia"=>"va", "north dakota"=>"nd", "wisconsin"=>"wi", "maryland"=>"md", "palau"=>"pw", "south dakota"=>"sd", "vermont"=>"vt", "nevada"=>"nv", "texas"=>"tx", "colorado"=>"co", "hawaii"=>"hi", "rhode island"=>"ri", "connecticut"=>"ct", "pennsylvania"=>"pa", "new york"=>"ny", "louisiana"=>"la", "washington"=>"wa", "south carolina"=>"sc", "alabama"=>"al", "nebraska"=>"ne", "new hampshire"=>"nh", "new mexico"=>"nm", "georgia"=>"ga", "delaware"=>"de", "utah"=>"ut", "montana"=>"mt", "idaho"=>"id", "iowa"=>"ia", "maine"=>"me", "florida"=>"fl", "id"=>"id", "ia"=>"ia", "tx"=>"tx", "il"=>"il", "in"=>"in", "tn"=>"tn", "ga"=>"ga", "de"=>"de", "ne"=>"ne", "nh"=>"nh", "nm"=>"nm", "ny"=>"ny", "nv"=>"nv", "nd"=>"nd", "dc"=>"dc", "nj"=>"nj", "nc"=>"nc", "al"=>"al", "vt"=>"vt", "ak"=>"ak", "va"=>"va", "ks"=>"ks", "az"=>"az", "ky"=>"ky", "ar"=>"ar", "sc"=>"sc", "sd"=>"sd", "fl"=>"fl", "pa"=>"pa", "pw"=>"pw", "me"=>"me", "mt"=>"mt", "ct"=>"ct", "co"=>"co", "md"=>"md", "ma"=>"ma", "ca"=>"ca", "mn"=>"mn", "mi"=>"mi", "ms"=>"ms", "mo"=>"mo", "ut"=>"ut", "hi"=>"hi", "ri"=>"ri", "oh"=>"oh", "ok"=>"ok", "or"=>"or", "la"=>"la", "wa"=>"wa", "wi"=>"wi", "wv"=>"wv", "wy"=>"wy" }

  set :static, true
  # set :root, File.expand_path(File.dirname(__FILE__))
  set :root, File.expand_path(File.dirname(__FILE__)).gsub("/config", '')
  set :public_folder, File.join(root, 'static')
  set :dump_errors, true
end

puts "Starting in #{ZipasaurusApp.environment} mode..."