module ConnectFour

  # Represents the Connect Four game board
  class Board
    attr_accessor :cells

    def initialize
      @cells = new_board
    end

    def new_board
      board = []
      6.times do
        row = []
        7.times { row << Cell.new }
        board << row
      end
      board
    end

    def new_piece
    end

  end

end