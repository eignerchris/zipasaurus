class Api < ZipasaurusApp

  CACHE_TIME = 7200
  
  before do
    content_type 'application/json'
    cache_control :public, max_age: CACHE_TIME
  end

  get '/zip/:code' do
    code   = params[:code]
    record = CouchPotato.database.view(Zip.by_code(code)).first
    
    record.to_json
  end

  get '/state/:state' do
    state   = params[:state].upcase
    records = CouchPotato.database.view(Zip.by_state(state))
    
    records.to_json
  end

  get '/state/:state/city/:city' do
    state = params[:state].upcase
    city  = params[:city].upcase

    records = CouchPotato.database.view(Zip.by_state(state)).select { |r| r['city'] == city }

    records.to_json
  end

  get '/state/:state/county/:county' do
    state  = params[:state].upcase
    county = params[:county].upcase

    records = CouchPotato.database.view(Zip.by_state(state)).select { |r| r['county'] == county }
  
    records.to_json
  end
end