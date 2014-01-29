require 'sinatra'
require 'csv'
require 'json'

words = CSV.read('words.csv')
# CSV.readを使うと[[a, b, c]]な配列になるので代入
words = words[0]

get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/api' do
  content_type :json
  words[rand(words.length)].to_json
end
