require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require :default
require 'pp'

require File.join(File.expand_path(File.dirname(__FILE__)), 'controller.rb')
require File.join(File.expand_path(File.dirname(__FILE__)), 'api.rb')

Dir.glob(['lib', 'models'].map! {|d| File.join File.expand_path(File.dirname(__FILE__)), d, '*.rb'}).each {|f| require f}

puts "Starting in #{Sinatra::Base.environment} mode.."

class Sinatra::Base
  configure :development do
    MongoMapper.connection = Mongo::Connection.new('localhost')
    MongoMapper.database = 'zipinfo'
  end

  configure :production do
    MongoMapper.config = {'production' => {'uri' => ENV['MONGOHQ_URL']}}
    MongoMapper.connect('production')
    Zip.ensure_index(:code)
    Zip.ensure_index(:city)
    Zip.ensure_index(:state)
  end
  
  use Rack::ShowExceptions if development?
  use Rack::MethodOverride
  use Rack::Session::Cookie, :key => 'iamdelta.session',
                             :path => '/',
                             :expire_after => 2592000, # In seconds
                             :secret => 'lj239cp0s9dd13093KK@jdl@DDa1Gw'
    
  set :static, true
  set :root, File.expand_path(File.dirname(__FILE__))
  set :public, File.join(root, 'static')
  set :dump_errors, true
  register Sinatra::Namespace
end