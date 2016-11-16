require "spec_helper"

module ConnectFour
  describe Cell do

    describe "#initialize" do
      it "does not raise an error when initialized without arguments" do
        expect{ Cell.new }.to_not raise_error
      end

      it "does not raise an error when initialized with a state" do
        expect{ Cell.new("white") }.to_not raise_error
      end
    end

    let(:cell) { Cell.new("black") }

    describe "#state" do
      it "returns the state of the cell" do
        expect(cell.state).to eql("black")
      end

      it "does not raise an error when set to a new state" do
        expect{ cell.state = "white" }.to_not raise_error
      end

      describe "after setting the state to a new state" do
        it "returns the new state of the cell" do
          cell.state = "white"
          expect(cell.state).to eql("white")
        end
      end
    end

    describe "#==" do
      describe "given two cells with the same state 'black'" do
        it "returns true" do
          expect(Cell.new("black") == Cell.new("black")).to eql(true)
        end
      end

      describe "given two empty cells" do
        it "returns true" do
          expect(Cell.new == Cell.new).to eql(true)
        end
      end

      describe "given a cell with state 'black' and a cell "\
               "with state 'white'" do
        it "returns false" do
          expect(Cell.new("black") == Cell.new("white")).to eql(false)
        end
      end

      describe "given a cell with state 'black' and an empty cell" do
        it "returns false" do
          expect(Cell.new("black") == Cell.new).to eql(false)
        end
      end
    end

  end
end
