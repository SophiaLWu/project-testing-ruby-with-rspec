require "spec_helper"

module TicTacToe
  describe Game do
    let(:game) {Game.new}

    describe "#gameover?" do

      context "empty board" do
        it "returns false" do
          game.board.cells = [[Cell.new(" "), Cell.new(" "), Cell.new(" ")], 
                              [Cell.new(" "), Cell.new(" "), Cell.new(" ")],
                              [Cell.new(" "), Cell.new(" "), Cell.new(" ")]]
          expect(game.gameover?).to eql(false)
        end
      end

      context "all O's in top row" do
        it "returns true" do
          game.board.cells = [[Cell.new("O"), Cell.new("O"), Cell.new("O")], 
                              [Cell.new(" "), Cell.new(" "), Cell.new(" ")],
                              [Cell.new(" "), Cell.new(" "), Cell.new(" ")]]
          expect(game.gameover?).to eql(true)
        end
      end

      context "all X's in middle row" do
        it "returns true" do
          game.board.cells = [[Cell.new(" "), Cell.new("O"), Cell.new(" ")], 
                              [Cell.new("X"), Cell.new("X"), Cell.new("X")],
                              [Cell.new("O"), Cell.new("X"), Cell.new(" ")]]
          expect(game.gameover?).to eql(true)
        end
      end

      context "all X's in first column" do
        it "returns true" do
          game.board.cells = [[Cell.new("X"), Cell.new(" "), Cell.new("X")], 
                              [Cell.new("X"), Cell.new("O"), Cell.new("X")],
                              [Cell.new("X"), Cell.new("O"), Cell.new("O")]]
          expect(game.gameover?).to eql(true)
        end
      end

      context "all O's in last column" do
        it "returns true" do
          game.board.cells = [[Cell.new("X"), Cell.new(" "), Cell.new("O")], 
                              [Cell.new(" "), Cell.new("X"), Cell.new("O")],
                              [Cell.new("X"), Cell.new("O"), Cell.new("O")]]
          expect(game.gameover?).to eql(true)
        end
      end

      context "all X's in downhill diagonal" do
        it "returns true" do
          game.board.cells = [[Cell.new("X"), Cell.new(" "), Cell.new("O")], 
                              [Cell.new(" "), Cell.new("X"), Cell.new("O")],
                              [Cell.new("X"), Cell.new("O"), Cell.new("X")]]
          expect(game.gameover?).to eql(true)
        end
      end

      context "all O's in uphill diagonal" do
        it "returns true" do
          game.board.cells = [[Cell.new("X"), Cell.new(" "), Cell.new("O")], 
                              [Cell.new(" "), Cell.new("O"), Cell.new("O")],
                              [Cell.new("O"), Cell.new(" "), Cell.new("X")]]
          expect(game.gameover?).to eql(true)
        end
      end

      context "no row, column, or diagonal of all X's or O's in a "\
              "non-full board" do
        it "returns false" do
          game.board.cells = [[Cell.new(" "), Cell.new("X"), Cell.new("X")], 
                              [Cell.new("X"), Cell.new("O"), Cell.new("X")],
                              [Cell.new(" "), Cell.new("O"), Cell.new("O")]]
          expect(game.gameover?).to eql(false)
        end
      end

      context "full board with no winning row, column, or diagonal" do
        it "returns true" do
          game.board.cells = [[Cell.new("O"), Cell.new("X"), Cell.new("O")], 
                              [Cell.new("X"), Cell.new("X"), Cell.new("O")],
                              [Cell.new("O"), Cell.new("O"), Cell.new("X")]]
          expect(game.gameover?).to eql(true)
        end
      end

    end

    describe "#valid_input?" do

      context "given '1'" do
        it "returns true" do
          expect(game.valid_input?("1")).to eql(true)
        end
      end

      context "given '9'" do
        it "returns true" do
          expect(game.valid_input?("9")).to eql(true)
        end
      end

      context "given '0'" do
        it "returns false" do
          expect(game.valid_input?("0")).to eql(false)
        end
      end

      context "given '10'" do
        it "returns false" do
          expect(game.valid_input?("10")).to eql(false)
        end
      end

      context "given 'QUIT'" do
        it "returns true" do
          expect(game.valid_input?("QUIT")).to eql(true)
        end
      end

      context "given 'Restart'" do
        it "returns true" do
          expect(game.valid_input?("Restart")).to eql(true)
        end
      end

      context "given 'blahblah'" do
        it "returns false" do
          expect(game.valid_input?("blahblah")).to eql(false)
        end
      end

    end

    describe "#get_coordinates" do

      context "given '1'" do
        it "returns [0,0]" do
          expect(game.get_coordinates("1")).to eql([0,0])
        end
      end
      
      context "given '9'" do
        it "returns [2,2]" do
          expect(game.get_coordinates("9")).to eql([2,2])
        end
      end

      context "given '4'" do
        it "returns [1,0]" do
          expect(game.get_coordinates("4")).to eql([1,0])
        end
      end

    end

  end
end