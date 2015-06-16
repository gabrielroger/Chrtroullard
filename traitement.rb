require 'sinatra'
set :bind, "0.0.0.0"

get "/" do
erb :index
end

get "/propositions_articles" do
erb :propositions_articles
end