class Zip
  include DataMapper::Resource

  property :id,                Serial
  property :code,              String, key: true
  property :lat,               String
  property :lng,               String
  property :city,              String
  property :state_abbrev,      String, key: true
  property :state_full,        String
  property :county,            String, key: true
end