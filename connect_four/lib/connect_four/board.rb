module ConnectFour

  # Represents the Connect Four game board
  class Board
    attr_accessor :cells

    def initialize
      @cells = new_board(7, 6)
    end

    # Returns a new board with x rows and y columns, whereby:
    # => the 0th row represents the lowest row on the board
    # => the 0th column represents the leftmost column on the board
    def new_board(x, y)
      board = []
      y.times do
        row = []
        x.times { row << Cell.new }
        board << row
      end
      board
    end

    # Given a disc and a valid column number, adds the disc to that column
    # on the board by modifying @cells
    def add_disc(disc, column)
      @cells.each do |row|
        if row[column].state == " "
          row[column].state = disc
          break
        end
      end
    end

    # Returns true if the input column is a valid column, meaning that
    # it is in the range of 0-6 and is not a full column
    def valid_column?(column)
      column.between?(0, 6) && !full_column?(column)
    end

    # Returns true if the input column is full
    def full_column?(column)
      @cells.all? { |row| row[column].state != " " }
    end 

  end

end