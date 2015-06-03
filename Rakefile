require './config/environment'

namespace :db do
  desc "load zip code and info into db"
  task :load_zip_info do
    zip_data = File.read('data/US.txt').split("\n").map { |line| line.split("\t") }
    zip_data.map do |line|
      z = Zip.new({
        code: line[1], 
        lat: line[9], 
        lng: line[10], 
        city: line[2], 
        state_abbrev: line[4], 
        state_full: line[3], 
        county: line[5]
      })
      print '.' if z.save
    end
  end

  desc "wipe zip code data for reload"
  task :wipe do
    Zip.destroy_all
  end
end