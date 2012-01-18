require File.join(File.expand_path(File.dirname(__FILE__)), 'environment.rb')

map '/' do
  run Controller
end

map '/api/zipinfo' do
  run Api
end