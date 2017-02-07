class CommandLineInterface

  def initialize(keyword)
    @keyword = keyword
    @data = Documentation_data.new(keyword)
  end

  def run
    collect_doc_refs
    organize_search_data
    display_search_results

    collect_specific_data
    organize_specific_data
    display_specific_result

    launch_browser?
  end

  def smart_input(rules, msg)
    puts msg
    input = STDIN.gets.chomp
    while rules.all?{|r| r.match(input) == nil}
      if input.upcase == 'Q' or input.upcase == 'QUIT'
        #end program elegently
        exit
      else
        puts msg
        input = STDIN.gets.chomp
      end
    end
    input
  end

  #Step 1

  def collect_doc_refs
    #scrape doc for references to keyword
    @data.data[:raw] = Scraper.scrape_the_doc(@keyword)
  end

  def organize_search_data
    @data.organize_search_data
  end

  def display_search_results
    if @data.data[:final].length == 0
      puts "\nSorry, #{@keyword} was not found.\nPress any key to quit."
      STDIN.gets
      return
    end
    input = ""
    @data.data[:final].each_with_index do |result, i|
      puts ""
      puts "#{result[:idx]}. #{result[:text].colorize(:yellow)}\n#{result[:link].colorize(:light_blue)}"

      if i > 1 and i % 10 == 0
        puts "\npress [any key] to display next 10 results"
        input = smart_input([/\d/, ""], "\n(enter link number to display expand selected result)")
        break if input && input != ""
      end
    end
    if input
      @data.selected_link = @data.data[:final][input.to_i - 1][:link]
    end
  end

  #Step 2

  def collect_specific_data
    if @data.selected_link
      @data.specific = {:raw => Scraper.scrape_specific_result(@data.selected_link)}
    end
  end

  def organize_specific_data
    @data.organize_specific_data
  end

  def display_specific_result
    #dev
    puts @data.specific[:colorized]
  end


  def launch_browser?
    link = @data.selected_link
    puts "Type b to display in browser or any key to quit"
    browser = STDIN.gets.chomp
    if browser.upcase == 'B'
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
