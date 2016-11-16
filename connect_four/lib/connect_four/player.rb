module ConnectFour

  # Represents a single player in the Connect Four game
  class Player
    attr_reader :name, :color

    def initialize(name, color)
      @name = name
      @color = color
    end

  end

end