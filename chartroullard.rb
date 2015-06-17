require 'sinatra'
require 'sqlite3'
set :bind, "0.0.0.0"

get "/" do
db = SQLite3::Database.new 'chartroullard.db'
db.results_as_hash=true
@articles = db.execute( "select titre, article from articles where rubrique='articles'" )
p @articles
@articles ||=[]
erb :index
end

get "/propositions_articles" do
erb :propositions_articles
end

get "/presentation_chartroulle" do
	erb :presentation_chartroulle
end

get "/petites_annonces" do
db = SQLite3::Database.new 'chartroullard.db'
db.results_as_hash=true
@articles =  db.execute( "select titre, article from articles where rubrique='annonces'" )
@articles ||=[]
erb :petites_annonces
end

get "/archives" do
	erb :archives
end

post "/traitement" do
   p params
    db = SQLite3::Database.new 'chartroullard.db'
    db.execute("INSERT INTO articles (titre, article, rubrique)
              VALUES ( ?, ?, ?)", [params["titre_article"], params["article"], params["rubrique"]])
    erb :reponse
end