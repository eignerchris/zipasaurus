class Api < Sinatra::Base

  # Zip info for a given zip code
  #
  # @param [String] code - zip code
  # @return [String] json object containing city, state, lat, lng, etc.
  get '/byzip/:code' do
    z = Zip.where(:code => params[:code]).first
    z.to_json
  end

  # Zip info for a given state
  #
  # @param [String] state - 2 character state code
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/bystate/:state' do
    zs = Zip.all(:state => params[:state].upcase)
    zs.to_json
  end

  # Zip info for a given state and city
  #
  # @param [String] state - 2 character state code
  # @param [String] city - city name
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/bystate/:state/bycity/:city' do
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
    zs = Zip.all(:state => params[:state].to_s.upcase, :city => params[:city].upcase, :county => params[:county].upcase)
    zs.to_json
  end
end