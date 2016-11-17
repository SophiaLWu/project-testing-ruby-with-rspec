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

    # Returns the disc that the state is associated with for output purposes
    def disc
      if @state == "black"
        "\u{26AB}"
      elsif @state == "white"
        "\u{26AA}"
      else
        " "
      end
    end

  end

end