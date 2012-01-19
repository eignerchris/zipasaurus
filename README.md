# zipasaur.us #

## overview ##
zipasaur.us is a RESTish API for querying zip codes, cities, states, and counties.

## local development ##

1. install mongodb

	`sudo port install mongodb` or `brew install mongodb`

2. start mongod in a seperate console or in background
 
 	`mongod &`

3. bundle
	
	`bundle install`

4. import zip code data
	
	`rake db:load_zip_info`
        
5. start server
	
	`thin start`
