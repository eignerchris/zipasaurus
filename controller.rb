class Controller < ZipasaurusApp

  get '/?' do
    erb :index
  end

  CACHE_TIME = 7200

  get '/zip/:code' do
    content_type 'application/json'
    cache_control :public, max_age: CACHE_TIME

    code   = params[:code]
    record = CouchPotato.database.view(Zip.by_code(code)).first
    
    Zip.to_json(record).to_json
  end

  get '/state/:state' do
    content_type 'application/json'
    cache_control :public, max_age: CACHE_TIME

    state   = STATE_ABBREV[params[:state].downcase]
    return [].to_json unless state
    records = CouchPotato.database.view(Zip.by_state(state.upcase))
    
    Zip.to_json(records).to_json
  end

  get '/state/:state/city/:city' do
    content_type 'application/json'
    cache_control :public, max_age: CACHE_TIME

    state = STATE_ABBREV[params[:state].downcase]
    return [].to_json unless state
    city  = params[:city].upcase

    records = CouchPotato.database.view(Zip.by_state(state.upcase)).select { |r| r['city'] == city }

    Zip.to_json(records).to_json
  end

  get '/state/:state/county/:county' do
    content_type 'application/json'
    cache_control :public, max_age: CACHE_TIME
    
    state  = STATE_ABBREV[params[:state].downcase]
    return [].to_json unless state
    county = params[:county].upcase

    records = CouchPotato.database.view(Zip.by_state(state.upcase)).select { |r| r['county'] == county }
  
    Zip.to_json(records).to_json
  end
   
end
