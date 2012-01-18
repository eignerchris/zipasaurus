class Api < ZipasaurusApp

  CACHE_TIME = 7200
  
  before do
    content_type 'application/json'
    cache_control :public, :max_age => CACHE_TIME
  end

  # Zip info for a given zip code
  #
  # @param [String] code - zip code
  # @return [String] json object containing city, state, lat, lng, etc.
  get '/byzip/:code' do
    code   = params[:code]
    
    record = $memcache.get(code)
    
    if record.nil?
      record = Zip.where(:code => code).first
      $memcache.set(code, record)
    end
    
    record.to_json
  end

  # Zip info for a given state
  #
  # @param [String] state - 2 character state code
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/bystate/:state' do
    state   = params[:state].upcase

    records = $memcache.get(state)
    
    if records.nil?
      records = Zip.all(:state => state)
      $memcache.set(state, records)
    end
    
    records.to_json
  end

  # Zip info for a given state and city
  #
  # @param [String] state - 2 character state code
  # @param [String] city - city name
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/bystate/:state/bycity/:city' do
    state = params[:state].upcase
    city  = params[:city].upcase

    records = $memcache.get("#{state}_#{city}")
    if records.nil?
      records = Zip.all(:state => state, :city => city)
      $memcache.set("#{state}_#{city}", records)
    end

    records.to_json
  end

  # Zip info for a given state/city/county combo
  #
  # @param [String] state - 2 character state code
  # @param [String] city - city name
  # @param [String] county - county name
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/bystate/:state/bycity/:city/bycounty/:county' do
    state  = params[:state].upcase
    city   = params[:city].upcase
    county = params[:county].upcase

    records = $memcache.get("#{state}_#{city}_#{county}")
    if records.nil?
      records = Zip.all(:state => state, :city => city, :county => county)
      $memcache.set("#{state}_#{city}_#{county}", records)
    end
    
    records.to_json
  end
end