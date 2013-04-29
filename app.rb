class App < ZipasaurusApp
  CACHE_TIME = 7200

  before do
    cache_control :public, max_age: CACHE_TIME
  end

  get '/?' do
    erb :index
  end

  get '/zip/:code' do
    content_type 'application/json'

    record = Zip.first(code: params[:code])
    
    record.to_json(:exclude => [:id])
  end

  get '/state/:state' do
    content_type 'application/json'

    if params[:state].length > 2
      records = Zip.all(state_full: params[:state].capitalize)
    else
      records = Zip.all(state: params[:state].upcase)
    end
    
    records.to_json(:exclude => [:id])
  end

  get '/state/:state/city/:city' do
    content_type 'application/json'

    if params[:state].length > 2
      state = params[:state].capitalize
      city  = params[:city].titleize.gsub("+", ' ')
      city  = params[:city].titleize.gsub("%20", ' ')

      records = Zip.all(state_full: state, city: city)
    else
      state = params[:state].upcase
      city  = params[:city].titleize.gsub("+", ' ')
      records = Zip.all(state: state, city: city)
    end

    records.to_json(:exclude => [:id])
  end

  get '/state/:state/county/:county' do
    content_type 'application/json'
    
    if params[:state].length > 2
      state  = params[:state].capitalize
      county = params[:county].titleize.gsub("+", ' ')
      county  = params[:county].titleize.gsub("%20", ' ')

      records = Zip.all(state_full: state, county: county)
    else
      state  = params[:state].upcase
      county = params[:county].titleize.gsub("+", ' ')

      records = Zip.all(state: state, county: county)
    end
  
    records.to_json
  end
   
end
