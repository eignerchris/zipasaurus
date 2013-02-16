# zipasaur.us #

## overview ##
zipasaur.us is a RESTish API for querying zip codes, cities, states, and counties.

## local development ##

1. install mongodb

	`brew install couchdb`

2. start couchdb in a seperate console or in background
 
 	`couchdb`

3. bundle
	
	`bundle install`

4. import zip code data
	
	`rake db:load_zip_info`
        
5. start server
	
	`thin start`
