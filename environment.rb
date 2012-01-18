require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require :default
require 'pp'

require File.join(File.expand_path(File.dirname(__FILE__)), 'controller.rb')
require File.join(File.expand_path(File.dirname(__FILE__)), 'api.rb')

Dir.glob(['lib', 'models'].map! {|d| File.join File.expand_path(File.dirname(__FILE__)), d, '*.rb'}).each {|f| require f}

class Sinatra::Base
  configure :development do
    MongoMapper.connection = Mongo::Connection.new('localhost')
    MongoMapper.database = 'zipinfo'
    use Rack::ShowExceptions
  end

  configure :production do
    ENV['APP_ROOT'] ||= File.dirname(__FILE__)
    require 'newrelic_rpm'
    MongoMapper.config = {'production' => {'uri' => ENV['MONGOHQ_URL']}}
    MongoMapper.connect 'production' 
    Zip.ensure_index :code 
    Zip.ensure_index :city 
    Zip.ensure_index :state
    $memcache = Dalli::Client.new
  end
  
  use Rack::CommonLogger
  use Rack::MethodOverride
  use Rack::JSONP
  use Rack::Cache,
    :verbose => true,
    :metastore => "memcached://#{ENV['MEMCACHE_SERVERS']}",
    :entitystore => "memcached://#{ENV['MEMCACHE_SERVERS']}"

  set :static, true
  set :root, File.expand_path(File.dirname(__FILE__))
  set :public, File.join(root, 'static')
  set :dump_errors, true
end

puts "Starting in #{Sinatra::Base.environment} mode..."