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
          expect(all_empty_cells).to eql(true)
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


    describe "#diagonal_starts" do

      let(:board) { Board.new }
      describe "with a 7x6 board" do
        it "returns an object with the correct uphill "\
           "and downhill diagonal starts on the board" do
          diagonals = board.instance_variable_get(:@diagonal_starts)
          expect(diagonals).to eql(
            {:uphill=>[[0, 0], [0, 1], [0, 2], [0, 3], [1, 0], [1, 1], 
                       [1, 2], [1, 3], [2, 0], [2, 1], [2, 2], [2, 3]], 
             :downhill=>[[3, 0], [3, 1], [3, 2], [3, 3], [4, 0], [4, 1], 
                         [4, 2], [4, 3], [5, 0], [5, 1], [5, 2], [5, 3]]})
        end
      end

    end


    describe "#gameover?" do

      let(:board) { Board.new }

      ######### Tests for gameover based on full board or not #########
      describe "with an empty board" do
        it "returns false" do
          expect(board.gameover?).to eql(false)
        end
      end

      describe "with a partially filled board and no winning row, "\
               "column, or diagonal" do
        it "returns false" do
          board.cells[0][5].state = "black"
          board.cells[1][5].state = "black"
          board.cells[0][1].state = "white"
          board.cells[0][3].state = "black"
          board.cells[0][0].state = "white"
          expect(board.gameover?).to eql(false)
        end
      end

      describe "with an almost full board (except one cell) and no winning "\
               "row, column, or diagonal" do
        it "returns false" do
          board.cells.each_with_index do |row, i|
            row.each_with_index do |cell, j|
              if i == 2 || i == 3
                cell.state = j % 2 == 0 ? "black" : "white"
              else
                cell.state = j % 2 == 0 ? "white" : "black"
              end
            end
          end
          board.cells[5][0].state = " "
          expect(board.gameover?).to eql(false)
        end
      end

      describe "with a full board and no winning row, column, or diagonal" do
        it "returns true" do
          board.cells.each_with_index do |row, i|
            row.each_with_index do |cell, j|
              if i == 2 || i == 3
                cell.state = j % 2 == 0 ? "black" : "white"
              else
                cell.state = j % 2 == 0 ? "white" : "black"
              end
            end
          end
          expect(board.gameover?).to eql(true)
        end
      end

      ######### Tests for gameover based on winning row #########
      describe "with an empty board except for a winning row "\
               "for disc 'black' at row 0 starting at column 0" do
        it "returns true" do
          board.cells[0][0].state = "black"
          board.cells[0][1].state = "black"
          board.cells[0][2].state = "black"
          board.cells[0][3].state = "black"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with a winning row for disc 'white' "\
               "at row 1 starting at column 3" do
        it "returns true" do
          board.cells[0][0].state = "black"
          board.cells[0][1].state = "white"
          board.cells[0][2].state = "black"
          board.cells[0][3].state = "black"
          board.cells[0][4].state = "white"
          board.cells[0][5].state = "black"
          board.cells[0][6].state = "black"
          board.cells[1][3].state = "white"
          board.cells[1][4].state = "white"
          board.cells[1][5].state = "white"
          board.cells[1][6].state = "white"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with a winning row for disc 'black' "\
               "at row 5 starting at column 1" do
        it "returns true" do
          board.cells[5][1].state = "black"
          board.cells[5][2].state = "black"
          board.cells[5][3].state = "black"
          board.cells[5][4].state = "black"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with 3 in a row for disc 'black' "\
               "at row 2 starting at column 3" do
        it "returns false" do
          board.cells[2][3].state = "black"
          board.cells[2][4].state = "black"
          board.cells[2][5].state = "black"
          board.cells[2][6].state = "white"
          expect(board.gameover?).to eql(false)
        end
      end

      ######### Tests for gameover based on winning column #########
      describe "with an empty board except for a winning column "\
               "for disc 'black' at column 0 starting at row 0" do
        it "returns true" do
          board.cells[0][0].state = "black"
          board.cells[1][0].state = "black"
          board.cells[2][0].state = "black"
          board.cells[3][0].state = "black"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with an empty board except for a winning column "\
               "for disc 'white' at column 6 starting at row 2" do
        it "returns true" do
          board.cells[0][6].state = "white"
          board.cells[1][6].state = "black"
          board.cells[2][6].state = "white"
          board.cells[3][6].state = "white"
          board.cells[4][6].state = "white"
          board.cells[5][6].state = "white"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with 3 in a column for disc 'black'"\
               "at column 4 starting at row 0" do
        it "returns false" do
          board.cells[0][4].state = "black"
          board.cells[1][4].state = "black"
          board.cells[2][4].state = "black"
          board.cells[3][4].state = "white"
          board.cells[4][4].state = "black"
          board.cells[5][4].state = "black"
          expect(board.gameover?).to eql(false)
        end
      end

      ######### Tests for gameover based on winning diagonal #########
      describe "with an uphill winning diagonal for disc 'black' "\
               "starting at row 0, column 0" do
        it "returns true" do
          board.cells[0][0].state = "black"
          board.cells[1][1].state = "black"
          board.cells[2][2].state = "black"
          board.cells[3][3].state = "black"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with an uphill winning diagonal for disc 'white' "\
               "starting at row 2, column 0" do
        it "returns true" do
          board.cells[2][0].state = "white"
          board.cells[3][1].state = "white"
          board.cells[4][2].state = "white"
          board.cells[5][3].state = "white"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with an uphill winning diagonal for disc 'white' "\
               "starting at row 0, column 3" do
        it "returns true" do
          board.cells[0][3].state = "white"
          board.cells[1][4].state = "white"
          board.cells[2][5].state = "white"
          board.cells[3][6].state = "white"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with an uphill winning diagonal for disc 'white' "\
               "starting at row 2, column 3" do
        it "returns true" do
          board.cells[2][3].state = "white"
          board.cells[3][4].state = "white"
          board.cells[4][5].state = "white"
          board.cells[5][6].state = "white"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with an uphill 3-cell diagonal for disc 'white' "\
               "starting at row 2, column 3" do
        it "returns false" do
          board.cells[2][3].state = "white"
          board.cells[3][4].state = "white"
          board.cells[4][5].state = "white"
          board.cells[5][6].state = "black"
          expect(board.gameover?).to eql(false)
        end
      end

      describe "with an uphill 3-cell diagonal for disc 'white' "\
               "starting at row 3, column 0" do
        it "returns false" do
          board.cells[3][0].state = "white"
          board.cells[4][1].state = "white"
          board.cells[5][2].state = "white"
          expect(board.gameover?).to eql(false)
        end
      end

      describe "with a non-winnning filled uphill diagonal"\
               "starting at row 0, column 0" do
        it "returns false" do
          board.cells[0][0].state = "white"
          board.cells[1][1].state = "white"
          board.cells[2][2].state = "white"
          board.cells[3][3].state = "black"
          board.cells[4][4].state = "black"
          board.cells[5][5].state = "black"
          expect(board.gameover?).to eql(false)
        end
      end

      describe "with a downhill winning diagonal for disc 'black' "\
               "starting at row 5, column 3" do
        it "returns true" do
          board.cells[5][3].state = "black"
          board.cells[4][4].state = "black"
          board.cells[3][5].state = "black"
          board.cells[2][6].state = "black"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with a downhill winning diagonal for disc 'black' "\
               "starting at row 3, column 0" do
        it "returns true" do
          board.cells[3][0].state = "black"
          board.cells[2][1].state = "black"
          board.cells[1][2].state = "black"
          board.cells[0][3].state = "black"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with a downhill winning diagonal for disc 'white' "\
               "starting at row 3, column 3" do
        it "returns true" do
          board.cells[3][3].state = "white"
          board.cells[2][4].state = "white"
          board.cells[1][5].state = "white"
          board.cells[0][6].state = "white"
          expect(board.gameover?).to eql(true)
        end
      end

      describe "with a downhill 3-cell diagonal for disc 'white' "\
               "starting at row 5, column 3" do
        it "returns false" do
          board.cells[5][3].state = "white"
          board.cells[4][4].state = "white"
          board.cells[3][5].state = "white"
          board.cells[2][6].state = "black"
          expect(board.gameover?).to eql(false)
        end
      end

      describe "with a downhill 3-cell diagonal for disc 'white' "\
               "starting at row 2, column 0" do
        it "returns false" do
          board.cells[2][0].state = "white"
          board.cells[1][1].state = "white"
          board.cells[0][2].state = "white"
          expect(board.gameover?).to eql(false)
        end
      end

      describe "with a non-winnning filled downhill diagonal"\
               "starting at row 5, column 0" do
        it "returns false" do
          board.cells[5][0].state = "white"
          board.cells[4][1].state = "white"
          board.cells[3][2].state = "white"
          board.cells[2][3].state = "black"
          board.cells[1][4].state = "black"
          board.cells[0][5].state = "black"
          expect(board.gameover?).to eql(false)
        end
      end

    end


    describe "#to_s" do

      let(:board) { Board.new }
      describe "with an empty board" do
        it "returns an empty board as a string" do
          expect(board.to_s).to eql(" 0  1  2  3  4  5  6 \n" \
                                    "----------------------\n"\
                                    "|  |  |  |  |  |  |  |\n"\
                                    "----------------------\n"\
                                    "|  |  |  |  |  |  |  |\n"\
                                    "----------------------\n"\
                                    "|  |  |  |  |  |  |  |\n"\
                                    "----------------------\n"\
                                    "|  |  |  |  |  |  |  |\n"\
                                    "----------------------\n"\
                                    "|  |  |  |  |  |  |  |\n"\
                                    "----------------------\n"\
                                    "|  |  |  |  |  |  |  |\n"\
                                    "----------------------")
        end
      end

      describe "with all 'black' discs on the board " do
        it "returns a full board with all 'black' discs as a string" do
          board.cells.each do |row|
            row.each { |cell| cell.state = "black" }
          end
          expect(board.to_s).to eql(" 0  1  2  3  4  5  6 \n" \
                                    "----------------------\n"\
                                    "|⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |\n"\
                                    "----------------------\n"\
                                    "|⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |\n"\
                                    "----------------------\n"\
                                    "|⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |\n"\
                                    "----------------------\n"\
                                    "|⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |\n"\
                                    "----------------------\n"\
                                    "|⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |\n"\
                                    "----------------------\n"\
                                    "|⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |⚫ |\n"\
                                    "----------------------")
        end
      end

      describe "with a partially filled board with 'black' & 'white' discs " do
        it "returns the partially filled board as a string" do
          board.add_disc("black", 0)
          board.add_disc("black", 1)
          board.add_disc("black", 2)
          board.add_disc("white", 3)
          board.add_disc("black", 4)
          board.add_disc("white", 5)
          board.add_disc("black", 6)
          board.add_disc("black", 4)
          board.add_disc("black", 4)
          board.add_disc("white", 3)
          board.add_disc("white", 5)
          board.add_disc("white", 6)
          board.add_disc("white", 6)
          board.add_disc("black", 6)
          board.add_disc("white", 6)
          board.add_disc("white", 6)
          expect(board.to_s).to eql(" 0  1  2  3  4  5  6 \n" \
                                    "----------------------\n"\
                                    "|  |  |  |  |  |  |⚪ |\n"\
                                    "----------------------\n"\
                                    "|  |  |  |  |  |  |⚪ |\n"\
                                    "----------------------\n"\
                                    "|  |  |  |  |  |  |⚫ |\n"\
                                    "----------------------\n"\
                                    "|  |  |  |  |⚫ |  |⚪ |\n"\
                                    "----------------------\n"\
                                    "|  |  |  |⚪ |⚫ |⚪ |⚪ |\n"\
                                    "----------------------\n"\
                                    "|⚫ |⚫ |⚫ |⚪ |⚫ |⚪ |⚫ |\n"\
                                    "----------------------")
        end
      end

    end

  end
end
