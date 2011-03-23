class Controller < Sinatra::Base

  get '/?' do
    erb :index
  end

  get '/docs' do
    erb :docs
  end
  
  get '/perf-and-tech' do
    erb :'perf_and_tech'
  end
   
end
