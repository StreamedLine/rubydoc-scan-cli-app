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
        launch_browser?
      end
    end
    launch_browser?
  end

  def launch_browser?
    puts "\n(enter link number to launch browser)"
    usr_input = STDIN.gets.chomp #why does this work? (and not gets by itself)
    if /\d/.match(usr_input)
      link = @data.data[:final][usr_input.to_i - 1][:link]
      begin
         Launchy.open(link)
      rescue
        puts "Couldn't access browser. Link will be copied to clipboard instead."
        Clipboard.copy(link)
        puts "#{link} copied to cliboard!"
      end
    end
  end

end
