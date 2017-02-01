class Documentation_data
  attr_accessor :data

  def initialize(word = "")
    @data = {word: word, raw: []}
    @@history << @data
  end

  def organize_data
    @data[:raw].each do |cat|
      @data[cat[0].to_sym] = cat[1]
    end
  end

  def self.all
    @@history
  end
end
