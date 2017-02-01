require 'open-uri'
require 'nokogiri'

class Scraper
  BASE_PATH = "http://ruby-doc.org/core"

  def self.scrape_the_doc(keyword)
    puts "#{keyword} in scraper"



  end
end

#ays.each{|e| puts "#{e.text} \n " + "http://ruby-doc.org/core/#{e['href']}"  if e.text.split(" (")[0] == "to_sym"}
