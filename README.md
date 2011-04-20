# zipasaur.us #

## overview ##
zipasaur.us is a RESTish API for querying zip codes, cities, states, and counties.

## technical details ##

1. install mongodb

	`sudo port install mongodb`

2. start mongod
 
  `mongod`

3. bundle
	
	`bundle install`

4. import zip code data
	
	`rake db:load_zip_info`
        
5. start server
	
	`thin start`
