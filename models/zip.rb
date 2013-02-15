class Zip < CouchRest::Model::Base
  
  property :code,   String
  property :lat,    String
  property :lng,    String
  property :city,   String
  property :state,  String
  property :county, String
  
  design do
    view :by_code
    view :by_state
  end

  def as_json(options={})
    { code: code,
      lat: lat,
      lng: lng,
      city: city,
      state: state,
      county: county }
  end
end