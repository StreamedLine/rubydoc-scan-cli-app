class Documentation_data
  attr_accessor :data, :selected_link, :specific

  @@history = []

  def initialize(word = "")
    @data = {word: word, raw: nil, final: nil}
    @specific = {}
    @selected_link = nil
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

  def organize_specific_data
    #header, blurb, code, link
  end

  def self.all
    @@history
  end
end
