require "colorize"

module TicTacToe

  # Represents the game board which consists of nine cells
  class Board
    attr_accessor :cells, :board_display

    def initialize
      @cells = []
      3.times do
        row = []
        3.times do
          row << Cell.new
        end
        @cells << row
      end
      @board_display = create_board
    end

    # Creates the instructions sample board and prints it
    def print_instructions_board
      cell_number = 1
      @cells.each do |row|
        row.each do |cell|
          cell.state = cell_number.to_s
          cell_number += 1
        end
      end

      puts "Sample board with cell numbers:"
      puts
      puts create_board
    end

    # Creates the tic-tac-toe board in string format
    def create_board
      board = ""
      horizontal_border = "---+---+---"

      @cells.each_with_index do |row, col|
        row.each_with_index do |cell, i|
          unless i == 0
            board << "|"
          end
          if cell.state == "X"
            color = :red
          elsif cell.state == "O"
            color = :blue
          end
          board << " #{cell.state} ".colorize(color)
        end
        unless col == 2
          board << "\n#{horizontal_border}\n"
        end
      end

      board
    end

    # Prints the board in a pretty way
    def print_board
      puts
      puts "=" * 70
      puts
      puts "CURRENT BOARD:"
      puts
      puts @board_display
      puts
    end

  end

end