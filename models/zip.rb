class Zip
  include CouchPotato::Persistence
  
  property :code,   type: String
  property :lat,    type: String
  property :lng,    type: String
  property :city,   type: String
  property :state,  type: String
  property :county, type: String

  view :by_code, key: :code
  view :by_state, key: :state

  def to_json(options={})
    { code: code,
      lat: lat,
      lng: lng,
      city: city,
      state: state,
      county: county }
  end
end