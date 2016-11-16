require "spec_helper"

module TicTacToe
  describe Cell do

    context "#initialize" do
      it "is initialized with a value of ' '" do
        cell = Cell.new
        expect(cell.state).to eq " "
      end

      it "can be initialized with a value of 'X'" do
        cell = Cell.new("X")
        expect(cell.state).to eq "X"
      end
    end


  end
end