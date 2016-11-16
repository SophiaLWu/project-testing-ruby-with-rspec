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
      describe "given x = 7 and y = 6" do
        it "creates a 7x6 board with all empty cells" do
          default_board = board.new_board(7, 6)
          expect(default_board.size).to eql(6)
          expect(default_board[0].size).to eql(7)
          all_empty_cells = default_board.all? do |row| 
                              row.all? { |cell| cell.state == " " }
                            end
          expect(all_empty_cells).to eq(true)
        end
      end
    end

    describe "#add_disc" do
      describe "given 'white' and 0 with an empty column 0" do

        let(:empty_board) { Board.new }

        it "adds a 'white' disc to the board at row 0, column 0" do
          empty_board.add_disc("white", 0)
          expect(empty_board.cells[0][0].state).to eql("white")
        end
      end

      describe "given 'white' and 1 with one black disc already in column 1" do

        board_1 = Board.new
        board_1.cells[0][1].state = "black"
        board_1.add_disc("white", 1)

        it "adds a 'white' disc to the board at row 1, column 1" do
          expect(board_1.cells[1][1].state).to eql("white")
        end

        it "keeps the black disc at row 0, column 1" do
          expect(board_1.cells[0][1].state).to eql("black")
        end
      end

      describe "given 'white' and 6 two times with four black discs "\
               "already in column 6" do

        board_2 = Board.new
        board_2.cells[0][6].state = "black"
        board_2.cells[1][6].state = "black"
        board_2.cells[2][6].state = "black"
        board_2.cells[3][6].state = "black"
        board_2.add_disc("white", 6)
        board_2.add_disc("white", 6)

        it "adds a 'white' disc to the board at row 4, column 6" do
          expect(board_2.cells[4][6].state).to eql("white")
        end

        it "adds a 'white' disc to the board at row 5, column 6" do
          expect(board_2.cells[5][6].state).to eql("white")
        end

        it "keeps the four black discs at rows 0-3, column 6" do
          expect(board_2.cells[0][6].state).to eql("black")
          expect(board_2.cells[1][6].state).to eql("black")
          expect(board_2.cells[2][6].state).to eql("black")
          expect(board_2.cells[3][6].state).to eql("black")
        end
      end

      describe "given 'white' and 3 and then 'black' and 4 with two white "\
               "discs already in both columns 3 and 4" do

        board_3 = Board.new
        board_3.cells[0][3].state = "white"
        board_3.cells[1][3].state = "white"
        board_3.cells[0][4].state = "white"
        board_3.cells[1][4].state = "white"
        board_3.add_disc("white", 3)
        board_3.add_disc("black", 4)

        it "adds a 'white' disc to the board at row 2, column 3" do
          expect(board_3.cells[2][3].state).to eql("white")
        end

        it "adds a 'black' disc to the board at row 2, column 4" do
          expect(board_3.cells[2][4].state).to eql("black")
        end

        it "keeps the white discs at rows 0 and 1 for columns 3 and 4" do
          expect(board_3.cells[0][3].state).to eql("white")
          expect(board_3.cells[1][3].state).to eql("white")
          expect(board_3.cells[0][4].state).to eql("white")
          expect(board_3.cells[1][4].state).to eql("white")
        end
      end

    end

    describe "#valid_column?" do
      let(:board) { Board.new }

      describe "given column -1 on an empty board" do
        it "returns false" do
          expect(board.valid_column?(-1)).to eql(false)
        end
      end

      describe "given column 7 on an empty board" do
        it "returns false" do
          expect(board.valid_column?(7)).to eql(false)
        end
      end

      describe "given column 0 on an empty board" do
        it "returns true" do
          expect(board.valid_column?(0)).to eql(true)
        end
      end

      describe "given column 6 on an empty board" do
        it "returns true" do
          expect(board.valid_column?(6)).to eql(true)
        end
      end

      describe "given column 1 on a full column 1" do
        it "returns false" do
          board.cells.each do |row|
            row[1].state = "black"
          end
          expect(board.valid_column?(1)).to eql(false)
        end
      end

      describe "given column 6 on an almost full column 6" do
        it "returns true" do
          board.cells.each do |row|
            row[6].state = "black"
          end
          board.cells[5][6].state = " "
          expect(board.valid_column?(6)).to eql(true)
        end
      end

      describe "given column 4 on a completely full board except column 4" do
        it "returns true" do
          board.cells.each do |row|
            row.each { |cell| cell.state = "black" }
          end
          board.cells[5][4].state = " "
          expect(board.valid_column?(4)).to eql(true)
        end
      end

      describe "given each column on a completely full board" do
        it "returns false for each column in the board" do
          board.cells.each do |row|
            row.each { |cell| cell.state = "black" }
          end
          expect(board.valid_column?(0)).to eql(false)
          expect(board.valid_column?(1)).to eql(false)
          expect(board.valid_column?(2)).to eql(false)
          expect(board.valid_column?(3)).to eql(false)
          expect(board.valid_column?(4)).to eql(false)
          expect(board.valid_column?(5)).to eql(false)
          expect(board.valid_column?(6)).to eql(false)
        end
      end

    end

  end
end
