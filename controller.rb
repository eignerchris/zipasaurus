class Controller < Sinatra::Base

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
