class Api < ZipasaurusApp

  CACHE_TIME = 7200
  
  before do
    content_type 'application/json'
    cache_control :public, max_age: CACHE_TIME
  end

  # Zip info for a given zip code
  #
  # @param [String] code - zip code
  # @return [String] json object containing city, state, lat, lng, etc.
  get '/zip/:code' do
    code   = params[:code]
    record = Zip.by_code.key(code).first
    
    record.to_json
  end

  # Zip info for a given state
  #
  # @param [String] state - 2 character state code
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/state/:state' do
    state   = params[:state].upcase
    records = Zip.by_state.key(state).all
    
    records.to_json
  end

  # Zip info for a given state and city
  #
  # @param [String] state - 2 character state code
  # @param [String] city - city name
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/state/:state/city/:city' do
    state = params[:state].upcase
    city  = params[:city].upcase

    records = Zip.by_state.key(state).collect { |r| r.city == city }

    records.to_json
  end

  # Zip info for a given state/city/county combo
  #
  # @param [String] state - 2 character state code
  # @param [String] city - city name
  # @param [String] county - county name
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/state/:state/city/:city/county/:county' do
    state  = params[:state].upcase
    city   = params[:city].upcase
    county = params[:county].upcase

    records = Zip.by_state.key(state).collect {|r| r.city == city }.collect { |r| r.county == county }
  
    records.to_json
  end
end