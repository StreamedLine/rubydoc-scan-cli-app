class Documentation_data
  attr_accessor :data

  @@history = []

  def initialize(word = "")
    @data = {word: word, raw: nil}
    @@history << @data
  end

  def organize_data
    @data[:raw].sort{|a,b| a.text <=> b.text}
    @data.each_with_index do |e, i|
      @data[i.to_sym] = i 
      @data[:text] = e.text
      @data[:link] = Scraper.path + '/' + e['href']
    end
    @data
  end

  def self.all
    @@history
  end
end
