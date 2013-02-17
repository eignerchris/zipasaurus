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

  def self.to_json(data)
    if data.is_a? Array
      data.collect do |r|
        { code: r['code'],
          lat: r['lat'],
          lng: r['lng'],
          city: r['city'],
          state: r['state'],
          county: r['county'] }
      end
    elsif data.is_a? Hash
      { code: data['code'],
        lat: data['lat'],
        lng: data['lng'],
        city: data['city'],
        state: data['state'],
        county: data['county'] }
    end
  end
end