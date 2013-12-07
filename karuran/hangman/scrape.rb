require 'open-uri'
require 'nokogiri'
require 'csv'

words = []
pageNames = ['chu1', 'chu2', 'chu3', 'kou1', 'kou2', 'kou3']

pageNames.each do |name|
  url = "http://www.eigo-duke.com/tango/#{name}"
  doc = Nokogiri::HTML(open(url))

  doc.css('td.hpb-cnt-tb-cell3').each do |node|
    words << node.text if node.text.length >= 5 && node.text =~ /[a-z]/
  end
end

CSV.open('words.csv', 'w') do |csv|
  csv << words
end
