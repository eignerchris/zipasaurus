class Controller < Sinatra::Base

  get '/?' do
    erb :index
  end

  get '/perf-and-tech' do
    erb :'perf_and_tech'
  end
  
  get '/zips/:code' do
    z = Zip.all(:code => params[:code]).first
    z.to_json
  end
  
  get '/cities/:city' do
    zs = Zip.all(:city => params[:city].to_s.upcase)
    zs.to_json
  end
  
  get '/states/:state' do
    zs = Zip.all(:state => params[:state].to_s.upcase)
    zs.to_json
  end
end
