require "spec_helper"

module ConnectFour
  describe Game do

    describe "#initialize" do

      it "does not raise an error when initialized without arguments" do
        expect{ Game.new }.to_not raise_error
      end

      it "does not raise an error when initialized with 2 player names" do
        expect{ Game.new("Bob", "Mary") }.to_not raise_error
      end

      let(:game) { Game.new }

      it "initializes an empty board" do
        expect(game.board.cells.all? do |row|
                 row.all? { |cell| cell.state == " " }
               end).to eql(true)
      end

      it "sets the current player to be Player 1" do
        current_player = game.instance_variable_get(:@current_player)
        player_1 = game.instance_variable_get(:@player1)
        expect(current_player == player_1).to eql(true)
      end

    end


    describe "#column_choice" do

      let (:game) { Game.new }

      describe "when user chooses column 0" do
        before do
          io_obj = double
          expect(game).to receive(:gets).and_return(io_obj)
          expect(io_obj).to receive(:chomp).and_return(0)
        end

        it "prompts user to enter a column to drop their disc" do
          expect { game.column_choice }.to \
          output("Please enter the column you would "\
                 "like to drop your disc:\n>> ").to_stdout
        end

        it "returns 0" do
          expect(game.column_choice).to eql(0)
        end

      end

      describe "when user chooses column 6" do
        before do
          io_obj = double
          expect(game).to receive(:gets).and_return(io_obj)
          expect(io_obj).to receive(:chomp).and_return(6)
        end

        it "prompts user to enter a column to drop their disc" do
          expect { game.column_choice }.to \
          output("Please enter the column you would "\
                 "like to drop your disc:\n>> ").to_stdout
        end

        it "returns 6" do
          expect(game.column_choice).to eql(6)
        end

      end

      describe "when user chooses column -1 and then chooses column 0" do
        before do
          io_obj = double
          expect(game).to receive(:gets).and_return(io_obj).twice
          expect(io_obj).to receive(:chomp).and_return(-1)
          expect(io_obj).to receive(:chomp).and_return(0)
        end

        it "prompts user to enter a column to drop their disc and "\
           "then prompts user to enter a valid column" do
          expect { game.column_choice }.to \
          output("Please enter the column you would "\
                 "like to drop your disc:\n>> Not a valid column. "\
                 "Please enter a valid column:\n>> ").to_stdout
        end

        it "returns 0" do
          expect(game.column_choice).to eql(0)
        end

      end

      describe "when user chooses column 3 when it's full, and then chooses "\
               "column 8, and then chooses column 2" do
        
        before do
          game.board.cells[0][3].state = "black"
          game.board.cells[1][3].state = "black"
          game.board.cells[2][3].state = "black"
          game.board.cells[3][3].state = "black"
          game.board.cells[4][3].state = "black"
          game.board.cells[5][3].state = "black"
          io_obj = double
          expect(game).to receive(:gets).and_return(io_obj).exactly(3).times
          expect(io_obj).to receive(:chomp).and_return(3)
          expect(io_obj).to receive(:chomp).and_return(8)
          expect(io_obj).to receive(:chomp).and_return(2)
        end

        it "prompts user to enter a column to drop their disc and "\
           "then prompts user to enter a valid column twice" do
          expect { game.column_choice }.to \
          output("Please enter the column you would "\
                 "like to drop your disc:\n>> Not a valid column. "\
                 "Please enter a valid column:\n>> Not a valid column. "\
                 "Please enter a valid column:\n>> ").to_stdout
        end

        it "returns 2" do
          expect(game.column_choice).to eql(2)
        end

      end

    end


    describe "#take_turn" do

      let(:game) {Game.new }
      let(:player_1) { game.instance_variable_get(:@player1) }
      let(:player_2) { game.instance_variable_get(:@player2) }

      describe "with an empty board and the user wanting to add a "\
               "'black' disc to column 0" do
        before do
          io_obj = double
          expect(game).to receive(:gets).and_return(io_obj)
          expect(io_obj).to receive(:chomp).and_return(0)
        end

        it "successfully adds the 'black' disc to the board at column 0" do
          expect(game.board.cells[0][0].state).to eql(" ")
          game.take_turn
          expect(game.board.cells[0][0].state).to eql("black")
        end

        it "switches the current player" do
          expect(game.instance_variable_get(:@current_player)).to eql(player_1)
          game.take_turn
          expect(game.instance_variable_get(:@current_player)).to eql(player_2)
        end
      end

      describe "with an almost full column 6 and the user wanting to add a "\
               "'black' disc to column 6" do
        before do
          game.board.cells[0][6].state = "black"
          game.board.cells[1][6].state = "black"
          game.board.cells[2][6].state = "white"
          game.board.cells[3][6].state = "black"
          game.board.cells[4][6].state = "white"
          io_obj = double
          expect(game).to receive(:gets).and_return(io_obj)
          expect(io_obj).to receive(:chomp).and_return(6)
        end

        it "successfully adds the 'black' disc to the board at column 6" do
          expect(game.board.cells[5][6].state).to eql(" ")
          game.take_turn
          expect(game.board.cells[5][6].state).to eql("black")
        end

        it "switches the current player" do
          expect(game.instance_variable_get(:@current_player)).to eql(player_1)
          game.take_turn
          expect(game.instance_variable_get(:@current_player)).to eql(player_2)
        end
      end

    end


    describe "#switch_current_player" do

      let(:game) { Game.new }
      let(:player_1) { game.instance_variable_get(:@player1) }
      let(:player_2) { game.instance_variable_get(:@player2) }

      describe "when the current player is Player 1" do
        it "switches the current player to Player 2" do
          current_player = game.instance_variable_get(:@current_player)
          expect(current_player == player_1).to eql(true)
          game.switch_current_player
          current_player = game.instance_variable_get(:@current_player)
          expect(current_player == player_2).to eql(true)
        end
      end

      describe "when the current player is Player 2" do
        it "switches the current player to Player 1" do
          game.instance_variable_set(:@current_player, player_2)
          current_player = game.instance_variable_get(:@current_player)
          expect(current_player == player_2).to eql(true)
          game.switch_current_player
          current_player = game.instance_variable_get(:@current_player)
          expect(current_player == player_1).to eql(true)
        end
      end

    end

  end
end
