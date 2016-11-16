module ConnectFour

  # Represents a single player in the Connect Four game
  class Player
    attr_reader :name, :disc

    def initialize(name, disc)
      @name = name
      @disc = disc
    end

  end

end