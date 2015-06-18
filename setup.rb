require "sequel"

if ENV["RACK_ENV"] == "production"
  DB = Sequel.connect(ENV["DATABASE_URL"])
else 
  require "sqlite3"
  DB = Sequel.connect('sqlite://chartroullard.db')
end

DB.alter_table(:articles) do
  add_column :auteur, String
end