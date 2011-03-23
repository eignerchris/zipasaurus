class Zip
  include MongoMapper::Document
  
  key :code,   String
  key :lat,    String
  key :lng,    String
  key :city,   String
  key :state,  String
  key :county, String
  
end