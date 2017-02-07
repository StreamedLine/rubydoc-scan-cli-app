class CommandLineInterface

  def initialize(keyword)
    @keyword = keyword
    @data = Documentation_data.new(keyword)
  end

  def run
    collect_doc_refs
    organize_data
    display_search_results
    display_specific_result
  end

  def smart_input(rules, msg)
    puts msg
    input = gets.chomp
    while rules.any{|r| r.match(input) != nil}
      if input.upcase == 'Q' or input.upcase == 'QUIT'
        #end program elegently
        exit
      else
        puts msg
        input = gets.chomp
      end
    end
    input
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
        input = smart_input([/\d/, ""], "\n(enter link number to display expand selected result)")
        break if input && input != ""
      end
    end
    if input
      @data.selected_link = @data.data[:final][usr_input.to_i - 1][:link]
    end
  end

  def display_specific_result
    @data.selected_link ? Scraper.scrape_specific_result(@data.selected_link) : nil
  end

  def launch_browser?
    if /\d/.match(usr_input)
      link = @data.selected_link
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
