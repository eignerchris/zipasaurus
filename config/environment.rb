require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require :default

class ZipasaurusApp < Sinatra::Base

  require File.join(File.expand_path(File.dirname(__FILE__)), '../app.rb')
  require File.join(File.expand_path(File.dirname(__FILE__)), '../models/zip.rb')

  configure :development do
    use Rack::ShowExceptions
    DataMapper.setup(:default, 'postgres://root:@localhost/zipasaurus')
    DataMapper.auto_upgrade!
  end

  configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
    DataMapper.auto_upgrade!
  end
  
  use Rack::CommonLogger
  use Rack::MethodOverride
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', :headers => :any, :methods => :get
    end
  end

  set :static, true
  set :root, File.expand_path(File.dirname(__FILE__)).gsub("/config", '')
  set :public_folder, File.join(root, 'static')
  set :dump_errors, true
end

puts "Starting in #{ZipasaurusApp.environment} mode..."
