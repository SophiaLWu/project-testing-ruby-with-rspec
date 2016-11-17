module ConnectFour

  # Represents the Connect Four game board
  class Board
    attr_accessor :cells

    def initialize
      @cells = new_board(7, 6)
      @rows = 6
      @columns = 7
      @diagonal_starts = all_diagonal_starts
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
    # it is in the range of 0-6 and is not a full column, and
    # false otherwise
    def valid_column?(column)
      column.between?(0, 6) && !full_column?(column)
    end

    # Returns true if the game is over, in which either a player gets
    # 4 in a row/column/diagonal or the board is full,
    # and false otherwise
    def gameover?
      full_board? || winning_row? || winning_column? || 
      winning_uphill_diagonal? || winning_downhill_diagonal?
    end

    private

    # Returns true if the input column is full and false otherwise
    def full_column?(column)
      @cells.all? { |row| row[column].state != " " }
    end

    # Returns true if the board is full and false otherwise
    def full_board?
      @cells.all? do |row|
        row.all? { |cell| cell.state != " " }
      end
    end

    # Returns true if there is a winning row and false otherwise
    def winning_row?
      @cells.any? do |row|
        found = false
        (@columns - 3).times do |i|
          first_cell = row[i]
          unless first_cell.state == " "
            if row[i..i + 3].all? { |cell| cell == first_cell }
              found = true
              break
            end
          end
        end
        found
      end
    end

    # Returns true if there is a winning column and false otherwise
    def winning_column?
      found = false
      @columns.times do |column|
        (@rows - 3).times do |i|
          unless @cells[i][column].state == " "
            if @cells[i][column] == @cells[i+1][column] &&
               @cells[i+1][column] == @cells[i+2][column] &&
               @cells[i+2][column] == @cells[i+3][column]
              found = true
              break
            end
          end
        end
      end
      found
    end

    # Returns an object with uphill and downhill keys that link to 
    # 2D arrays of[row, col] positions on the board that are
    # valid starts to a 4-cell diagonal
    def all_diagonal_starts
      starts = {uphill: [], downhill: []}
      @rows.times do |row|
        @columns.times do |column|
          if @cells[row + 3] && @cells[row + 3][column + 3]
            starts[:uphill] << [row, column]
          elsif @cells[row - 3] && @cells[row - 3][column + 3]
            starts[:downhill] << [row, column]
          end
        end
      end
      starts
    end

    # Returns true if there is a winning uphill diagonal and false otherwise
    def winning_uphill_diagonal?
      possible_uphills = @diagonal_starts[:uphill]
      possible_uphills.any? do |row, column|
        if @cells[row][column].state == " "
          false
        else
          @cells[row][column] == @cells[row + 1][column + 1] &&
          @cells[row + 1][column + 1] == @cells[row + 2][column + 2] &&
          @cells[row + 2][column + 2] == @cells[row + 3][column + 3]
        end
      end
    end

    # Returns true if there is a winning downhill diagonal and false otherwise
    def winning_downhill_diagonal?
      possible_downhills = @diagonal_starts[:downhill]
      possible_downhills.any? do |row, column|
        if @cells[row][column].state == " "
          false
        else
          @cells[row][column] == @cells[row - 1][column + 1] &&
          @cells[row - 1][column + 1] == @cells[row - 2][column + 2] &&
          @cells[row - 2][column + 2] == @cells[row - 3][column + 3]
        end
      end
    end

  end
end
