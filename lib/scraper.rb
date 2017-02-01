require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  BASE_PATH = "http://ruby-doc.org/core"

  def self.search_hrefs(hrefs, keyword) 
    hrefs.collect do |e| 
      e if Regexp.new(keyword).match(e.text)
    end.compact
  end

  def self.scrape_the_doc(keyword)
    page = open(BASE_PATH)
    hrefs = Nokogiri::HTML(page).css("a")

    results = search_hrefs(hrefs, keyword)
    #dev
    puts " "
    results.each{|e| puts "#{e.text}\n   #{BASE_PATH}/#{e['href']}\n-----------"}
  end
end

#hrefs.collect{|e| puts "#{e.text} \n " + "http://ruby-doc.org/core/#{e['href']}"  if e.text.split(" (")[0] == keyword}
