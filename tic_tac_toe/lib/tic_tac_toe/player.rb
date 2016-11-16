module TicTacToe

  # Represents a single human player
  class Player
    attr_reader :name, :mark

    def initialize(name, mark)
      @name = name
      @mark = mark
    end

  end

end