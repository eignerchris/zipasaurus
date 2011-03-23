class Api < Sinatra::Base

  # Zip info for a given zip code
  #
  # @param [String] code - zip code
  # @return [String] json object containing city, state, lat, lng, etc.
  get '/zips/:code' do
    z = Zip.where(:code => params[:code]).first
    z.to_json
  end

  # Zip info for a given state
  #
  # @param [String] state - 2 character state code
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/states/:state' do
    zs = Zip.where(:state => params[:state].to_s.upcase).all
    zs.to_json
  end

  # Zip info for a given state and city
  #
  # @param [String] state - 2 character state code
  # @param [String] city - city name
  # @return [Array] array of json objects containing city, state, lat, lng, etc.
  get '/states/:state/cities/:city' do
    zs = Zip.where(:state => params[:state].to_s.upcase, :city => params[:city].to_s.upcase).all
    zs.to_json
  end

  # get '/cities/:city' do
  #     zs = Zip.where(:city => params[:city].to_s.upcase).all
  #     zs.to_json
  #   end
end