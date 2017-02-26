
class Start_program
  def self.run(user_input = nil)
    user_input = user_input || ARGV[0]

    if user_input == nil
      puts "Please type keyword:"
      user_input = gets.chomp
    end

    CommandLineInterface.new(user_input).run
  end
end
