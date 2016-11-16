require "spec_helper"

module TicTacToe
  describe Player do

    context "#initialize" do
      it "raises an error when initialized without arguments" do
        expect { Player.new }.to raise_error(ArgumentError)
      end

      it "raises an error when initialized with just 1 argument" do
        expect { Player.new("Player 2") }.to raise_error(ArgumentError)
      end

      it "does not raise an error when initialized with arguments" do
        expect { Player.new("Player 1", "X") }.to_not raise_error
      end
    end

    context "#name" do
      it "returns the name" do
        player = Player.new("Player 1", "X")
        expect(player.name) == "Player 1"
      end

      it "returns the mark" do
        player = Player.new("Player 2", "O")
        expect(player.mark) == "O"
      end
    end

  end
end