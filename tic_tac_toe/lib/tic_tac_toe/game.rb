module TicTacToe

  # Represents a new game and includes all methods involving gameplay mechanics
  class Game
    attr_accessor :board

    def initialize
      @board = Board.new
      @player1 = Player.new("Player 1", "X")
      @player2 = Player.new("Player 2", "O")
      @current_player = @player1
      @cell_coordinates = {"1" => [0,0], "2" => [0,1], "3" => [0,2],
                           "4" => [1,0], "5" => [1,1], "6" => [1,2],
                           "7" => [2,0], "8" => [2,1], "9" => [2,2]}
      @quit = false
      @restart = false
      @winner = nil
    end

    # Begins the game with instructions and a call to the play_game method
    def start_game
      instructions_board = Board.new

      puts """
      Hello there! Welcome to Tic Tac Toe!
      - Player 1, your mark is 'X'.
      - Player 2, your mark is 'O'.

      Rules:
      - You will take turns marking the empty cells in the
        game board with your corresponding mark.
      - When prompted, type in the cell number that you want to
        place your mark in. The board below the instructions
        shows a sample board with the cell numbers.
      - The player that places 3 marks in a row on the board wins!

      Options
      - Type 'quit' at any point to quit the game.
      - Type 'restart' at any point to restart the game.
      """
      puts
      instructions_board.print_instructions_board
      puts 

      puts "Please type 'ready' when you are ready to start playing!"
      print ">> "
      input = gets.chomp
      play_game if input.downcase == "ready"

    end

    # Includes a loop that continues to allow players to add marks to
    # the board and exits the loop once the game is over
    def play_game
      @board.print_board
      until @quit || @restart || gameover?
        cell = take_turn(@current_player)
        if !cell.nil?
          coordinates = get_coordinates(cell)
          change_board(coordinates) if valid_cell?(coordinates)
        end
        @current_player = switch_player(@current_player)
        @board.print_board unless @restart || @quit
      end
      reset_board if @restart
      ending_screen if gameover?

    end

    # Returns an array of coordinates of the cell the player wants to mark
    def take_turn(player)
      if player == @player1
        color = :red
      else
        color = :blue
      end
      puts "#{player.name} ('#{player.mark}'), it's your turn.".colorize(color)
      puts
      puts "What cell do you want to place your '#{player.mark}'? "\
           "(Choose a cell number from 1-9)"
      print ">> "
      cell = get_input
      return if quit_or_restart?(cell)
      cell
    end

    # Uses the @coordinates variable to change the cell's state to
    # the player's mark, thus changing the board state
    def change_board(coordinates)
      @board.cells[coordinates[0]][coordinates[1]].state = @current_player.mark
      @board.board_display = @board.create_board
    end

    # Returns true if game is over and false otherwise
    def gameover?
      winning_row? || winning_column? || winning_diagonal? || full_board?
    end

    # If there is a winning row, sets @winner and returns true
    def winning_row?
      @board.cells.each do |row|
        first_cell_state = row[0].state
        if first_cell_state != " " && first_cell_state == row[1].state &&
           first_cell_state == row[2].state
           @winner = first_cell_state == @player1.mark ? @player1 : @player2
           return true
        end
      end
      false
    end

    # If there is a winning column, sets @winner and returns true
    def winning_column?
      0.upto(2) do |col| 
        first_cell_state = @board.cells[0][col].state
        if first_cell_state != " " && 
           first_cell_state == @board.cells[1][col].state &&
           first_cell_state == @board.cells[2][col].state
           @winner = first_cell_state == @player1.mark ? @player1 : @player2
           return true
        end
      end
      false
    end

    # If there is a winning diagonal, sets @winner and returns true
    def winning_diagonal?
      top_left_cell_state = @board.cells[0][0].state
      top_right_cell_state = @board.cells[0][2].state
      if top_left_cell_state != " " && 
         top_left_cell_state == @board.cells[1][1].state &&
         top_left_cell_state == @board.cells[2][2].state
         @winner = top_left_cell_state == @player1.mark ? @player1 : @player2
         true
      elsif top_right_cell_state != " " &&
            top_right_cell_state == @board.cells[1][1].state &&
            top_right_cell_state == @board.cells[2][0].state
         @winner = top_right_cell_state == @player1.mark ? @player1 : @player2
         true
      else
        false
      end

    end

    # Returns true if the board is full
    def full_board?
      @board.cells.each do |row|
        row.each do |cell|
          return false if cell.state == " "
        end
      end
      true
    end

    # Creates ending screen for game finish
    def ending_screen
      if @winner == @player1
        color = :red
      elsif @winner == @player2
        color = :blue
      else
        color = :green
      end
      puts
      puts "The game is finished."
      if @winner.nil?
        puts "The game is a draw!".colorize(color)
      else
        puts "#{@winner.name} wins the game!".colorize(color)
      end
      puts
      puts "Would you like to play again? (Y/N)"
      print ">> "
      response = gets.chomp
      reset_board if response.downcase == "y"
    end

    # If user input is quit or restart, stops the turn and allows for
    # breaking out of the play_game loop
    def quit_or_restart?(input)
      if input.downcase == "quit"
        @quit = true
        true
      elsif input.downcase == "restart"
        @restart = true
        true
      else
        false
      end
    end

    # Resets the board
    def reset_board
      puts
      puts "=" * 70
      puts
      puts "Starting new game..."
      @board = Board.new
      @restart = false
      @current_player = @player1
      @winner = nil
      play_game
    end

    # Returns valid input when the user is prompted
    def get_input
      input = gets.chomp
      until valid_input?(input)
        puts "Invalid input. Please type in an EMPTY cell number from "\
             "1-9, 'quit', or 'restart'."
        print ">> "
        input = gets.chomp
      end
      input
    end

    # Returns true if the input is valid (quit, restart, or coordinates)
    def valid_input?(input)
      if 1 <= input.to_i && input.to_i <= 9
        coordinates = get_coordinates(input)
        valid_cell?(coordinates)
      elsif input.downcase == "quit" || input.downcase == "restart"
        true
      else
        false
      end
    end

    # Returns an array of coordinates given a cell number as a string
    def get_coordinates(cell)
      row = @cell_coordinates[cell][0]
      col = @cell_coordinates[cell][1]
      [row, col]
    end

    # Returns true if coordinates correspond to an empty cell
    def valid_cell?(coordinates)
      @board.cells[coordinates[0]][coordinates[1]].state == " "
    end

    # Switches the player from player1 to player2 and vice versa 
    def switch_player(player)
      if player == @player1
        player = @player2
      else 
        player = @player1
      end
    end

  end

end