
class Hangman 
  def initialize
    @words = File.readlines "5desk.txt"
    @words.map! { |i| i.gsub("\r\n", "").downcase }
    @words.select! { |i| i.length >= 5 && i.length <= 12}
    @secret_word = @words.sample
    @board = Board.new(@secret_word)
  end
  
  def instructions
    puts "=========================="
    puts "=== Welcome to Hangman ==="
    puts "=========================="
    @board.display
    puts "You can 6 chances to guess the right word"
    puts "You can save at anytime by inputing 1"
    
  end

end
class Board
  attr_accessor :guess, :alphabet, :blanks, :remaining
    
  def initialize(word)
    @blanks = []
    word.length.times {@blanks << "_" }
    @secret_word = word.split('')
    @alphabet = ('a'..'z').to_a
    @guessed = []
    @remaining = 6
  end
  
  def display
    illustrate
    puts ""
    puts blanks.join(" ")
    puts ""
    puts "(#{@guessed.join(" ")})"
  end

  def illustrate
    case @remaining
    when 6
      puts " ________________"
      puts "|                |"
      puts "|   _________    |"
      puts "|    |/    |     |" 
      puts "|    |           |"
      puts "|    |           |"
      puts "|    |           |"
      puts "|    |           |"
      puts "|   /|\\          |"   
      puts "| _/_|_\\ __      |"
      puts "|________________|"          
    when 5
      puts " ________________"
      puts "|                |"
      puts "|   _________    |"
      puts "|    |/    |     |" 
      puts "|    |     0     |"
      puts "|    |           |"
      puts "|    |           |"
      puts "|    |           |"
      puts "|   /|\\          |"   
      puts "| _/_|_\\ __      |"
      puts "|________________|" 
    when 4
      puts " ________________"
      puts "|                |"
      puts "|   _________    |"
      puts "|    |/    |     |" 
      puts "|    |     0     |"
      puts "|    |    /|     |"
      puts "|    |           |"
      puts "|    |           |"
      puts "|   /|\\          |"   
      puts "| _/_|_\\ __      |"
      puts "|________________|" 
    when 3
      puts " ________________"
      puts "|                |"
      puts "|   _________    |"
      puts "|    |/    |     |" 
      puts "|    |     0     |"
      puts "|    |    /|\\    |"
      puts "|    |           |"
      puts "|    |           |"
      puts "|   /|\\          |"   
      puts "| _/_|_\\ __      |"
      puts "|________________|" 
    when 2
      puts " ________________"
      puts "|                |"
      puts "|   _________    |"
      puts "|    |/    |     |" 
      puts "|    |     0     |"
      puts "|    |    /|\\    |"
      puts "|    |     |     |"
      puts "|    |           |"
      puts "|   /|\\          |"   
      puts "| _/_|_\\ __      |"
      puts "|________________|" 
    when 1
      puts " ________________"
      puts "|                |"
      puts "|   _________    |"
      puts "|    |/    |     |" 
      puts "|    |     0     |"
      puts "|    |    /|\\    |"
      puts "|    |     |     |"
      puts "|    |    /      |"
      puts "|   /|\\          |"   
      puts "| _/_|_\\ __      |"
      puts "|________________|" 
    when 0
      puts " ________________"
      puts "|  * HE DEAD *   |"
      puts "|   _________    |"
      puts "|    |/    |     |" 
      puts "|    |     0     |"
      puts "|    |    /|\\    |"
      puts "|    |     |     |"
      puts "|    |    / \\    |"
      puts "|   /|\\         |"   
      puts "| _/_|_\\ ____    |"
      puts "|________________|" 
    end
  end  
end


game = Hangman.new
game.instructions

