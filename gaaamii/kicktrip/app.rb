require 'sinatra'
require 'sass'
require 'slim'
require 'coffee-script'
require 'net/http'
require 'uri'
require 'json'

CATEGORIES = ["technology","art","design","food","publishing","music","film"]

get '/style.css' do
  sass :style
end

get '/app.js' do
  coffee :app
end

get '/' do
  category = CATEGORIES.sample
  uri = URI.parse("https://www.kickstarter.com/discover/categories/#{category}.json")
  json = Net::HTTP.get(uri)
  result = JSON.parse(json)
  result = result["projects"]
  num = rand(3)
  @id = result[num]["id"]
  @slug = result[num]["slug"]
  @title = result[num]["name"]
  slim :index
end

