class Controller < ZipasaurusApp

  get '/?' do
    erb :index
  end
  
  get '/perf-and-tech' do
    erb :'perf_and_tech'
  end
   
end
