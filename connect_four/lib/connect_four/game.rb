module ConnectFour

  # Represents a game of Connect Four
  class Game
    attr_accessor :board

    def initialize(player1="Player 1", player2="Player 2")
      @player1 = Player.new(player1, "black")
      @player2 = Player.new(player2, "white")
      @board = Board.new
      @current_player = @player1
    end

    # Starts up the game
    def start_game
      puts "Welcome to Connect Four!" +
           "\n\nThis is a two-player game where you each take turns dropping" +
           "\nyour colored disc down into one of the columns on the board." +
           "\n\nThe first player to form a horizontal, vertical, or diagonal" +
           "\nline of four of your colored discs wins!" +
           "\n\nPlayer 1: your disc color is 'black'" +
           "\nPlayer 2: your disc color is 'white'" +
           "\n\nGood luck and have fun!\n\n"
      play_round
    end

    # Plays one round of Connect Four
    def play_round
      until board.gameover?
        puts "-" * 60 + "\n\n"
        puts @board
        puts "\n"
        take_turn
      end
      switch_current_player
      puts "-" * 60 + "\n\n"
      puts @board
      puts "\nGame is over."
      if @board.full_board?
        puts "The game is a draw!"
      else
        puts "#{@current_player.name} (#{@current_player.disc}) won the game!"
      end
    end

    # Allows one turn to be taken by a player, whereby the player
    # drops his/her disc in a column
    def take_turn
      puts "#{@current_player.name} (#{@current_player.disc}), it's your turn."
      @board.add_disc(@current_player.disc, column_choice)
      switch_current_player
    end

    # Prompts user to choose a column to drop the disc and returns
    # a valid column choice as an integer
    def column_choice
      print "Please enter the column you would like to drop your disc:\n>> "
      choice = gets.chomp.to_i
      until @board.valid_column?(choice)
        print "Not a valid column. Please enter a valid column:\n>> "
        choice = gets.chomp.to_i
      end
      choice
    end

    # Switches the current player
    def switch_current_player
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  end

end