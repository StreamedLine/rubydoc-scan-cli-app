require 'open-uri'
require 'nokogiri'

class Scraper
  BASE_PATH = "http://ruby-doc.org/core"

  def self.scrape_the_doc(keyword)
    puts "#{keyword} in scraper"
  end
end
