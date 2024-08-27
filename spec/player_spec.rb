require "./lib/players/player"
require "./lib/players/human"
require "./lib/players/computer"
require "./lib/items/board"

describe Human do
  describe "#play_turn" do
    let(:board) { instance_double(Board) }
    subject(:human) { described_class.new(0) }
    context "when user inputs correct" do
      before do
        allow(human).to receive(:gets).and_return("9")
        allow(board).to receive(:save_move)
        allow(board).to receive(:show_board)
        allow(board).to receive(:valid?).and_return(true)
      end

      it "does shows exactly 3 messages" do
        expect(human).to receive(:puts).exactly(3).times
        human.play_turn(board)
      end
    end

    context "when user inputs incorrect then correct input" do
      before do
        allow(human).to receive(:gets).and_return("", "9")
        allow(board).to receive(:save_move)
        allow(board).to receive(:show_board)
        allow(board).to receive(:valid?).and_return(true)
      end

      it "does shows exactly 4 messages" do
        expect(human).to receive(:puts).exactly(4).times
        human.play_turn(board)
      end
    end

    context "when user invalid then valid input" do
      before do
        allow(human).to receive(:gets).and_return("2", "9")
        allow(board).to receive(:save_move)
        allow(board).to receive(:show_board)
        allow(board).to receive(:valid?).and_return(false, true)
      end

      it "does shows exactly 4 messages" do
        expect(human).to receive(:puts).exactly(4).times
        human.play_turn(board)
      end
    end
  end
end

describe Computer do
  describe "#play_turn" do
    let(:board) { instance_double(Board) }
    subject(:computer) { described_class.new(1) }
    context "when there is no valid move" do
      before do
        allow(board).to receive(:valid_moves).and_return([])
        allow(board).to receive(:save_move)
        allow(board).to receive(:show_board)
        allow(board).to receive(:puts)
        allow(computer).to receive(:puts)
      end

      it "returns nil" do
        expect(computer).to receive(:choose_move).and_return(nil)
        computer.play_turn(board)
      end
    end

    context "when there is winning move" do
      before do
        allow(board).to receive(:puts)
        allow(computer).to receive(:puts)
        allow(board).to receive(:valid_moves).and_return([1])
        allow(board).to receive(:winning_move?).and_return(true)
        allow(board).to receive(:save_move)
        allow(board).to receive(:show_board)
      end

      it "doesn't call find_loss" do
        expect(computer).not_to receive(:random_move)
        computer.play_turn(board)
      end

      it "doesn't call random_move" do
        expect(computer).not_to receive(:find_loss)
        computer.play_turn(board)
      end

      it "calls find_win with returns 1" do
        expect(computer).to receive(:find_win).and_return(1)
        computer.play_turn(board)
      end
    end

    context "when there is only losing move" do
      before do
        allow(board).to receive(:puts)
        allow(computer).to receive(:puts)
        allow(board).to receive(:valid_moves).and_return([1])
        allow(board).to receive(:winning_move?).and_return(false)
        allow(board).to receive(:losing_move?).and_return(true)
        allow(board).to receive(:save_move)
        allow(board).to receive(:show_board)
      end

      it "calls find_win and returns nil" do
        expect(computer).to receive(:find_win).and_return(nil)
        computer.play_turn(board)
      end

      it "doesn't call random_move" do
        expect(computer).not_to receive(:random_move)
        computer.play_turn(board)
      end

      it "calls find_loss with returns 1" do
        expect(computer).to receive(:find_loss).and_return(1)
        computer.play_turn(board)
      end
    end

    context "when there is no winning/losing move" do
      before do
        allow(board).to receive(:puts)
        allow(computer).to receive(:puts)
        allow(board).to receive(:valid_moves).and_return([1])
        allow(board).to receive(:winning_move?).and_return(false)
        allow(board).to receive(:losing_move?).and_return(false)
        allow(board).to receive(:save_move)
        allow(board).to receive(:show_board)
      end

      it "calls find_win and returns nil" do
        expect(computer).to receive(:find_win).and_return(nil)
        computer.play_turn(board)
      end

      it "calls find_loss with returns nil" do
        expect(computer).to receive(:find_loss).and_return(nil)
        computer.play_turn(board)
      end

      it "calls random_move and return 1" do
        expect(computer).to receive(:random_move).and_return(1)
        computer.play_turn(board)
      end
    end
  end
end
