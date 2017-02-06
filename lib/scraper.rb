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

  def self.traverseIt(chunk)
    chunk = chunk.children[0]
    while chunk.next
      if chunk.name == 'div'
        traverseIt(chunk)
        chunk = chunk.next
        next
      end
      if chunk.name == 'pre'
        puts '========================================'.colorize(:color => :red)
        puts chunk.inner_text.colorize(:color => :yellow).gsub('\r' , "").strip
      else
        if chunk.inner_text.split(" ").uniq.count < 2
          chunk=chunk.next
          next
        end
        puts chunk.inner_text.gsub(/^\s*[.]\s*$/, "") if chunk.inner_text && chunk.inner_text != "\n" && chunk.name != 'a'
      end
      chunk = chunk.next

    end
  end

  def self.scrape_specific_result(link)
    #DEV
    page = open(link)
    html = Nokogiri::HTML(page)
    result = html.css('a').detect {|n| n['name'] == "#{link.split('#')[1]}"}.parent
    #result.css('.method-callseq').each{|e| puts e.inner_text}
    #still missing the blocks of code!
    result.search('.method-click-advice').each{|e| e.remove}
    result.search('a').each{|e| e.remove}

    puts " "
    result.search('.method-callseq').each do |e|
      puts e.inner_text.colorize(:color => :green)
    end
    result.search('.method-callseq').each{|e| e.remove}

    puts " "
    traverseIt(result)
    puts " "
  end

  def self.path
    BASE_PATH
  end

end
