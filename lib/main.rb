require 'yaml'

class Hangman 
  def initialize
    @words = File.readlines "5desk.txt"
    @words.map! { |i| i.gsub("\r\n", "").downcase }
    @words.select! { |i| i.length >= 5 && i.length <= 12}
    @secret_word = @words.sample
    @board = Board.new(@secret_word)
  end
  
  def instructions
    puts "      =========================="
    puts "      === Welcome to Hangman ==="
    puts "      =========================="
    puts "       Guess up to 6 letters to "
    puts "       find the secret word and "
    puts "       save the innocent person "
    puts "       from an archane justice! "
    puts "      ==========================\n"
    puts "You can save the gamestate by entering \"save\" 
         and load last state with \"load\""
  end
  def play
    @win = false
    instructions()
    while @win == false
      puts "\n\n\n\n\n\n\n"
      @board.display
      @board.get_guess
      @board.check_guess
      @board.check_win
    end 
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
  
  def load_game
    loaded_game = File.read("SavedGames/save_game.yaml")
    game = YAML::load(loaded_game)

    @guessed = game[:@guessed]
    @secret_word = game[:@secret_word]
    @remaining = game[:@remaining]
    @blanks = game[:@blanks]
    

  end

  def save_game
    save = YAML::dump(self)
    Dir.mkdir("SavedGames") unless Dir.exists?("SavedGames")
    filename = "SavedGames/save_game.yaml"
    File.open(filename, 'w') do |file|
      file.puts save
    end
  end

  def display
    illustrate
    puts ""
    puts blanks.join(" ")
    puts ""
    puts "(#{@guessed.join(" ")})"
    puts "#{@remaining} guesses remaining"
  end

  def get_guess
    puts "\n\n\n"
    puts "Guess a letter\n"
    puts "input: "
    @guess = gets.chomp.downcase
    if @guess == "save"
      self.save_game
      puts "\n\n\n\n\n Game Saved!\n\n\n\n\n\n\n"
    elsif @guess == "load"
      self.load_game
    end
  end
  def check_guess 
    if @guess.length == 1
      if @guessed.include?(@guess)
        puts "You already guessed that letter"
      elsif @secret_word.include?(@guess) 
        @secret_word.each_with_index do |letter, index| 
          if @guess == letter
            @blanks[index] = @guess
          end
        end
      else
        @remaining -= 1
      end
      @guessed << @guess
    end
  end

  def check_win
    if @blanks == @secret_word
      puts "\n\n\n\n\n\n\n"
      puts "You won! Cut \'m down boys, done got worded right out"
      gameover()
    end
    if @remaining == 0
      puts "\n\n\n\n\n\n\n"
      puts "You lose!  Correct word: #{@secret_word}"
      gameover()
    end
  end

  def gameover
    puts "(N)ew game"
    puts "(L)oad game"
    response = gets.chomp
    if response.downcase == 'n'
      game = Hangman.new
      game.play
    elsif response.downcase == 'l'
      game.load_game
    end
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
      puts "|   /|\\          |"   
      puts "| _/_|_\\ ____    |"
      puts "|________________|" 
      puts" CORRECT ANSWER: #{@secret_word.join(" ")}"
    end
  end  
end


game = Hangman.new
game.play


