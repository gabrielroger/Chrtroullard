require "sqlite3"
require "sequel"

DB = Sequel.connect('sqlite://chartroullard.db')

DB.create_table :articles do
  primary_key :id
  String :titre
  String :article, :text => true
  String :rubrique
end