# Require bundle gem and load all gems
require 'bundler'
require 'open-uri'
require 'json'
Bundler.require

module Scrapable
  #
  # 純粋に最新のはてぶ20件をhashで返す関数
  # @params hatebu_name はてなのユーザー名
  # @return スクレイピング結果をhashで返す
  #
  def scrape(hatebu_name)
    url = "http://b.hatena.ne.jp/#{hatebu_name}/bookmark"

    result = []

    doc = Nokogiri::HTML(open(url),nil,"utf-8")
    doc.css("#page-content ul li.entry-block").each_with_index do |doc,i|
      result[i]  = {}
      result[i][:title] = doc.css("h3.entry-title a").text
      result[i][:url] = doc.css("h3.entry-title a").attr("href")
      result[i][:summery] = doc.css("blockquote p").text
    end
    result
  end

  #
  # 日ごとランダムに20件はてぶをhashで返す関数
  # @params hatebu_name はてなのユーザー名
  # @return スクレイピング結果をhashで返す
  #
  def rand_scrape(hatebu_name)
    url = "http://b.hatena.ne.jp/#{hatebu_name}/bookmark"
    result = []

    # ユーザーの最大ブックマーク数を取得
    doc = Nokogiri::HTML(open(url),nil,"utf-8")
    limit = doc.css("#profile-count-navi dl dd a")[0].text
    limit = limit.split(',').join('').to_i - 20

    # 乱数の初期値を日にちをもとに設定
    prng = Random.new(Date.today.to_time.to_i)

    # 日にち毎にランダムにスクレイピングする場所を設定する
    offset = prng.rand(limit)

    # ユーザーの過去記事をスクレイピング
    url = "#{url}?of=#{offset}"
    doc = Nokogiri::HTML(open(url),nil,"utf-8")
    doc.css("#page-content ul li.entry-block").each_with_index do |doc,i|
      result[i]  = {}
      result[i][:title] = doc.css("h3.entry-title a").text
      result[i][:url] = doc.css("h3.entry-title a").attr("href")
      result[i][:summery] = doc.css("blockquote p").text
    end

    # スクレイピング結果を返す
    result
  end
end

#
# Rem
# Sinatraアプリケーション本体
#

class Rem < Sinatra::Base

  configure :development do
    Bundler.require :development
    register Sinatra::Reloader
  end

  include Scrapable

  get '/user/:hatebu_name' do
    content_type :json

  begin
    result = {
      status:200,
      version:1,
      username:params[:hatebu_name],
      bookmarks:rand_scrape(params[:hatebu_name])
    }.to_json
  rescue Exception => e
    puts e.inspect
    halt 404
  end
  end

  not_found do
    content_type :json
    {status:404,version:1,errors:["404 Not Found"]}.to_json
  end

  error do
    content_type :json
    {status:500,version:1,errors:[env['sinatra.error'].name]}.to_json
  end
end

