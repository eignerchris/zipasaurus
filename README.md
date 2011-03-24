# zipasaur.us #

## overview ##
zipasaur.us is a RESTish API for querying zip codes, cities, states, and counties.

## technical details ##

1. install mongodb

	sudo port install mongodb

2. bundle
	
	bundle install

3. import zip code data
	
	rake db:load_zip_info
        
3. start server
	
	thin start -R config.ru -p 4567
