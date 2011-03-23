class Controller < Sinatra::Base

  get '/?' do
    erb :index
  end

  get '/perf-and-tech' do
    erb :'perf_and_tech'
  end
  
  ### API ###
  
  get '/zips/:code' do
    z = Zip.where(:code => params[:code]).first
    z.to_json
  end
  
  get '/states/:state' do
    zs = Zip.where(:state => params[:state].to_s.upcase).all
    zs.to_json
  end
  
  get '/states/:state/cities/:city' do
    zs = Zip.where(:state => params[:state].to_s.upcase, :city => params[:city].to_s.upcase).all
    zs.to_json
  end
  
  get '/cities/:city' do
     zs = Zip.where(:city => params[:city].to_s.upcase).all
     zs.to_json
   end
   
end
