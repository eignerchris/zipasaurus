require './config/environment'

namespace :db do
  
  desc "load zip code and info into db"
  task :load_zip_info do
    zip_data = File.read('data/US.txt').split("\n").map { |line| line.split("\t") }
    zip_data.map do |line|
      z = Zip.new({code: line[1], lat: line[9], lng: line[10], city: line[2], state: line[4], state_full: line[3],county: line[5] })
      print '.' if z.save
    end
  end

  # desc "update zip info from geonames"
  # task :update_zip_info do
  #   `curl -o /tmp/unzip.tar.gz "http://zipasaurus.s3.amazonaws.com/unzip.tar.gz"`
  #   `cd /tmp && tar zxvf unzip.tar.gz`
  #   `cp /tmp/unzip610b/unix/Makefile /tmp/unzip610b/`
  #   `cd /tmp/unzip610b && make generic`
  #   `cp /tmp/unzip610b/unzip /tmp/`
  #   `curl -o /tmp/US.zip "http://download.geonames.org/export/zip/US.zip"`
  #   `cd /tmp && ./unzip /tmp/US.zip -d /tmp`

  #   Zip.destroy!
  #   zip_data = File.read('/tmp/US.txt').split("\n").map { |line| line.split("\t") }
  #   zip_data.map do |line|
  #     z = Zip.new({code: line[1], lat: line[9], lng: line[10], city: line[2], state: line[4], state_full: line[3],county: line[5] })
  #     print '.' if z.save
  #   end
  # end
end