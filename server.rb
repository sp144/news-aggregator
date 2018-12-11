require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'csv'

set :bind, '0.0.0.0'  # bind to all interfaces

get "/" do
  redirect "/articles"
end

get "/articles" do
  @articles = []
  CSV.foreach('articles2.csv', headers: true) do |row|
    @articles << row
  end
  erb :index
end

get "/articles/new" do
  erb :articles_new
end

post "/submit" do
  @error_msg = nil
  if params["submit_article_title"] == "" || params["submit_article_url"] == "" || params["submit_article_description"] == ""
    redirect "/articles/new"
  else
    CSV.open('articles2.csv', 'a') do |file|
      file << [params["submit_article_title"], params["submit_article_url"], params["submit_article_description"]]
    end
    redirect "/articles"
  end
end
