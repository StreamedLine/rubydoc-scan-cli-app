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
    results
  end

  def self.path
    BASE_PATH
  end

end
