class Zip
  include DataMapper::Resource

  property :id,         Serial
  property :code,       String, key: true
  property :lat,        String
  property :lng,        String
  property :city,       String
  property :state,      String, key: true
  property :state_full, String
  property :county,     String, key: true

  # def to_json(options={})
  #   { code: code,
  #     lat: lat,
  #     lng: lng,
  #     city: city,
  #     state: state,
  #     state_full: state_full,
  #     county: county }
  # end
end