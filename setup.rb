require "sequel"

if ENV["RACK_ENV"] == "production"
  DB = Sequel.connect(ENV["DATABASE_URL"])
else 
  require "sqlite3"
  DB = Sequel.connect('sqlite://chartroullard.db')
end

DB.create_table :articles do
  primary_key :id
  String :titre
  String :article, :text => true
  String :rubrique
  String :auteur
end