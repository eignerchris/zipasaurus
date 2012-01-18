require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require :default
require 'pp'

class ZipasaurusApp < Sinatra::Base

  require File.join(File.expand_path(File.dirname(__FILE__)), 'controller.rb')
  require File.join(File.expand_path(File.dirname(__FILE__)), 'api.rb')
  require File.join(File.expand_path(File.dirname(__FILE__)), 'helpers.rb')

  Dir.glob(['lib', 'models'].map! {|d| File.join File.expand_path(File.dirname(__FILE__)), d, '*.rb'}).each {|f| require f}

  configure :development do
    MongoMapper.connection = Mongo::Connection.new('localhost')
    MongoMapper.database = 'zipinfo'
    use Rack::ShowExceptions
    
    $memcache = Dalli::Client.new
    
    use Rack::Cache,
      :verbose => true,
      :metastore => $memcache,
      :entitystore => $memcache
  end

  configure :production do
    ENV['APP_ROOT'] ||= File.dirname(__FILE__)
    
    MongoMapper.config = {'production' => {'uri' => ENV['MONGOHQ_URL']}}
    MongoMapper.connect 'production' 
    
    Zip.ensure_index :code 
    Zip.ensure_index :city 
    Zip.ensure_index :state
    
    $memcache = Dalli::Client.new

    use Rack::Cache,
      :verbose => true,
      :metastore => "memcached://#{ENV['MEMCACHE_SERVERS']}",
      :entitystore => "memcached://#{ENV['MEMCACHE_SERVERS']}"
  end
  
  use Rack::CommonLogger
  use Rack::MethodOverride
  use Rack::JSONP

  set :static, true
  set :root, File.expand_path(File.dirname(__FILE__))
  set :public, File.join(root, 'static')
  set :dump_errors, true

  helpers Helpers
end

puts "Starting in #{ZipasaurusApp.environment} mode..."