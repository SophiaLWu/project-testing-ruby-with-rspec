module ConnectFour

  # Represents a single cell in the Connect Four board
  class Cell
    attr_accessor :state

    def initialize(state=" ")
      @state = state
    end

  end

end