require 'colorize'

class CommandLineInterface

  def initialize(keyword)
    @keyword = keyword
    @data = Documentation_data.new
  end

  def run
    collect_doc_refs
    organize_data
    #dev
    puts "#{@keyword} in cli class"
  end

  def collect_doc_refs
    #scrape doc for references to keyword
    Scraper.scrape_the_doc(@keyword )
  end

  def organize_data
    #@@data.organize
  end

  def display_data
    #disply with colorize
  end

end
