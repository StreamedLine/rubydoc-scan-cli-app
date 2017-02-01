require 'colorize'

class CommandLineInterface
  BASE_PATH = "http://ruby-doc.org/core"

  def initialize(keyword)
    @@keyword = keyword
    @@data = Documentation_data.new
  end

  def run
    collect_doc_refs
    organize_data
    #dev
    puts @@keyword
  end

  def collect_doc_refs
    #scrape doc for references to keyword
  end

  def organize_data
    #@@data.organize
  end

  def display_data
    #disply with colorize
  end

end
