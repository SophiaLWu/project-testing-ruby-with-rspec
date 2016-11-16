require "spec_helper"

module TicTacToe
  describe Board do

    context "#initialize" do
      it "does not raise an error when initialized without arguments" do
        expect { Board.new }.to_not raise_error
      end
    end

    context "#cells" do
      it "returns an array of arrays with 9 cells" do
        cells = Board.new.cells
        expect(cells.size) == 3
        expect(cells[0].size) == 3
      end
    end

  end
end