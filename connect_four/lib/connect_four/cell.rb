module ConnectFour

  # Represents a single cell in the Connect Four board
  class Cell
    attr_accessor :state

    def initialize(state=" ")
      @state = state
    end

    # Allows two cells to be equated by their states
    def ==(other)
      @state == other.state
    end

  end

end