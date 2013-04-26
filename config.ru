require File.join(File.expand_path(File.dirname(__FILE__)), 'config/environment.rb')

map '/' do
  run App
end