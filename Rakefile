require './environment'

namespace :db do
  
  desc "load zip code and info into db"
  task :load_zip_info do
    zip_data = File.read('data/ZIP_CODES.txt').split("\n").map { |line| line.split(",") }
    zip_data.each do |blob|
      zip = Zip.create :code => blob[0], :lat => blob[1], :lng => blob[2], :city => blob[3], :state => blob[4], :county => blob[5]
      puts "created #{zip.inspect}"
    end
  end

  desc "boostraps database - destroys all zip documents"
  task :bootstrap do
    Zip.all.map(&:destroy)
  end
end