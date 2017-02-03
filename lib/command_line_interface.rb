class CommandLineInterface

  def initialize(keyword)
    @keyword = keyword
    @data = Documentation_data.new(keyword)
  end

  def run
    collect_doc_refs
    organize_data
    display_search_results
  end

  def collect_doc_refs
    #scrape doc for references to keyword
    @data.data[:raw] = Scraper.scrape_the_doc(@keyword)
  end

  def organize_data
    @data.organize_data
  end

  def display_search_results
    if @data.data[:final].length == 0
      puts "\nSorry, #{@keyword} was not found.\nPress any key to quit."
      STDIN.gets
      return
    end
    @data.data[:final].each_with_index do |result, i|
      puts ""
      puts "#{result[:idx]}. #{result[:text].colorize(:yellow)}\n#{result[:link].colorize(:light_blue)}"

      if i > 1 and i % 10 == 0
        puts "\npress [any key] to display next 10 results"
        #dev
        launch_browser? ? return : false
      end
    end
    launch_browser?  ? return : false
  end

  def display_specific_result(link)
    Scraper.scrape_specific_result(link)
  end

  def launch_browser?
    puts "\n(enter link number to launch browser)"
    usr_input = STDIN.gets.chomp #why does this work? (and not gets by itself)
    if /\d/.match(usr_input)
      link = @data.data[:final][usr_input.to_i - 1][:link]
      display_specific_result(link)
      begin
         Launchy.open(link)
      rescue
        puts "Couldn't access browser. Link will be copied to clipboard instead.".colorize(:red)
        Clipboard.copy(link)
        puts "#{link.colorize(:light_blue)} copied to cliboard!"
      end
      true
    else
      false
    end
  end

end
