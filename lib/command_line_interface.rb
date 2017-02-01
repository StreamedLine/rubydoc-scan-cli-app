require 'colorize'

class CommandLineInterface

  def initialize(keyword)
    @keyword = keyword
    @data = Documentation_data.new(keyword)
  end

  def run
    collect_doc_refs
    organize_data
    display_data
  end

  def collect_doc_refs
    #scrape doc for references to keyword
    @data.data[:raw] = Scraper.scrape_the_doc(@keyword)
  end

  def organize_data
    @data.organize_data
  end

  def display_data
    #disply with colorize
    # binding.pry
    @data.data[:final].each_with_index do |result, i|
      puts ""
      puts "#{result[:idx]}. #{result[:text]}\n    #{result[:link]}"

      if i > 1 and i % 10 == 0
        puts "press any key to display next 10 results"
        usr_input = STDIN.gets
      end
    end

  end

end
