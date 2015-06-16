require 'sinatra'
require 'yaml/store'
set :bind, "0.0.0.0"

get "/" do
@store = YAML::Store.new 'articles.yml'
@articles = @store.transaction { @store['articles'] }
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
@store = YAML::Store.new 'articles.yml'
@articles = @store.transaction { @store['articles'] }
@articles ||=[]
erb :petites_annonces
end

get "/archives" do
	erb :archives
end

post "/traitement" do
   p params
    @store = YAML::Store.new 'articles.yml'
  @store.transaction do
    @store['articles'] ||= {}
    id=@store['articles'].size+1
    @store['articles'][id] =params
  end
    erb :reponse
end