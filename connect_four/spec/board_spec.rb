require "spec_helper"

module ConnectFour
  describe Board do

    describe "#initialize" do
      it "does not raise an error when initialized without arguments" do
        expect{ Board.new }.to_not raise_error
      end
    end

    let(:board) { Board.new }

    describe "#new_board" do
      it "creates a 7x6 board with all empty cells" do
        board_1 = board.new_board
        expect(board_1.size).to eql(6)
        expect(board_1[0].size).to eql(7)
        all_empty_cells = board_1.all? do |row| 
                            row.all? { |cell| cell.state == " " }
                          end
        expect(all_empty_cells).to eq(true)
      end
    end

  end
end
