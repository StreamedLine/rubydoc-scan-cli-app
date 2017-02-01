require 'colorize'

class CommandLineInterface

  def initialize(keyword)
    @keyword = keyword
    @data = Documentation_data.new(keyword)
  end

  def run
    collect_doc_refs
    organize_data
  end

  def collect_doc_refs
    #scrape doc for references to keyword
    @data[:raw] = Scraper.scrape_the_doc(@keyword)
  end

  def organize_data
    @data.organize_data
  end

  def display_data
    #disply with colorize
  end

end
