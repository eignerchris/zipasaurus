class Api < Sinatra::Base

  CACHE_TIME = 7200
  
  # Zip info for a given zip code
  #
  # @param [String] code - zip code
  # @return [String] json object containing city, state, lat, lng, etc.
  get '/byzip/:code' do
    content_type 'application/json'
    cache_control :public, :max_age => CACHE_TIME
    record = $memcache.get(params[:code])
    if record.nil?
      record = Zip.where(:code => params[:code]).first
      $memcache.set(params[:code], record)
    end
    record.to_json
  end

  # Zip info for a given state
  #
  # @param [String] state - 2 character state code
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/bystate/:state' do
    content_type 'application/json'
    cache_control :public, :max_age => CACHE_TIME
    zs = Zip.all(:state => params[:state].upcase)
    zs.to_json
  end

  # Zip info for a given state and city
  #
  # @param [String] state - 2 character state code
  # @param [String] city - city name
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/bystate/:state/bycity/:city' do
    content_type 'application/json'
    cache_control :public, :max_age => CACHE_TIME
    zs = Zip.all(:state => params[:state].to_s.upcase, :city => params[:city].upcase)
    zs.to_json
  end

  # Zip info for a given state/city/county combo
  #
  # @param [String] state - 2 character state code
  # @param [String] city - city name
  # @param [String] county - county name
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/bystate/:state/bycity/:city/bycounty/:county' do
    content_type 'application/json'
    cache_control :public, :max_age => CACHE_TIME
    zs = Zip.all(:state => params[:state].to_s.upcase, :city => params[:city].upcase, :county => params[:county].upcase)
    zs.to_json
  end
end