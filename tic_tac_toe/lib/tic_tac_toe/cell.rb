module TicTacToe

  # Represents a single cell in the board that has a state of " ", "X", or "O"
  class Cell
    attr_accessor :state

    def initialize(state = " ")
      @state = state
    end

  end

end