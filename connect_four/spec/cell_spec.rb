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

  end
end
