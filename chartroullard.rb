require 'sinatra'
require 'sequel'
set :bind, "0.0.0.0"

if ENV["RACK_ENV"] == "production"
  DB = Sequel.connect(ENV["DATABASE_URL"])
else 
  require 'sqlite3'
  DB = Sequel.connect('sqlite://chartroullard.db')
end

get "/" do
@articles = DB[ "select titre, article from articles where rubrique='articles'" ]
erb :index
end

get "/propositions_articles" do
erb :propositions_articles
end

get "/presentation_chartroulle" do
	erb :presentation_chartroulle
end

get "/petites_annonces" do
@articles =  DB[ "select titre, article from articles where rubrique='annonces'" ]
erb :petites_annonces
end

get "/archives" do
	erb :archives
end

post "/traitement" do
    DB[:articles].insert([:titre, :article, :rubrique], [params["titre_article"], params["article"], params["rubrique"]])
    erb :reponse
end