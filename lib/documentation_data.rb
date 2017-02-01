class Documentation_data
  attr_accessor :data

  @@history = []

  def initialize(word = "")
    @data = {word: word, raw: nil, final: nil}
    @@history << @data
  end

  def organize_data
    @data[:raw].sort{|a,b| a.text <=> b.text}

    final = @data[:raw].each_with_index.collect do |e, i|
      organized = {}
      organized[:idx] = i + 1
      organized[:text] = e.text
      organized[:link] = Scraper.path + '/' + e['href']
      organized
    end
    @data[:final] = final
    @data
  end

  def self.all
    @@history
  end
end
