require 'sinatra'
require 'sequel'
set :bind, "0.0.0.0"

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Non autorisé ======>   <a href=\"/\">Page d'acceuil</a>\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [ENV['ID'], ENV['MDP']]
  end
end

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
@articles =  DB[ "select titre, article, auteur from articles where rubrique='annonces'" ]
erb :petites_annonces
end

get "/archives" do
	 @articles = DB[ "select titre, article, auteur from articles where rubrique='archives'" ]
  erb :archives
end

get "/page_direction" do
  @articles = DB[ "select * from articles" ]
  erb :page_direction
end

post "/traitement" do
    DB[:articles].insert([:titre, :article, :rubrique, :auteur], [params["titre_article"], params["article"], params["rubrique"], params["auteur"]])
    erb :reponse
end

post "/suppression" do
   protected!
   DB[:articles].filter({:id => params["suppression"]}).delete
   redirect to "/page_direction"
end

post "/archive" do
   protected!
   DB[:articles].filter({:id => params["archive"]}).update({:rubrique =>'archives'})
   redirect to "/page_direction"
end

