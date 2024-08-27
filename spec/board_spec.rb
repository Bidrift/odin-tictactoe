require "./lib/items/board"
require "./lib/players/computer"
require "./lib/items/circle"

describe Board do
  describe "#show_board" do
    subject(:display_board) { described_class.new }
    it "outputs every position" do
      expect(display_board).to receive(:puts).exactly(3).times
      display_board.show_board
    end
  end

  describe "#save_move" do
    let(:player) { instance_double(Player, player_id: 0) }
    subject(:save_board) { described_class.new }
    let(:choice) { 1 }
    it "changes board[0][0] to Cross" do
      expect { save_board.save_move(choice, player) }.to change {
                                                           save_board.instance_variable_get(:@board)[0][0].class
                                                         }.to eq(Cross)
    end
  end

  describe "#valid_moves" do
    context "when board is empty" do
      subject(:valid_board) { described_class.new }
      let(:valid_array) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }
      it "returns an array with length 9" do
        expect(valid_board.valid_moves.length).to eq(valid_array.length)
      end

      it "returns an array from 1 to 9" do
        expect(valid_board.valid_moves).to eq(valid_array)
      end
    end

    context "when board has a cross" do
      let(:player) { instance_double(Computer, player_id: 0) }
      subject(:valid_board) { described_class.new }

      it "returns an array with length 8" do
        valid_board.save_move(1, player)
        expect(valid_board.valid_moves.length).to eq(8)
      end

      it "doesn't return 1 in the array" do
        valid_board.save_move(1, player)
        expect(valid_board.valid_moves).not_to include(1)
      end
    end

    context "when board has a circle" do
      let(:player) { instance_double(Computer, player_id: 1) }
      subject(:valid_board) { described_class.new }

      it "returns an array with length 8" do
        valid_board.save_move(1, player)
        expect(valid_board.valid_moves.length).to eq(8)
      end

      it "doesn't return 1 in the array" do
        valid_board.save_move(1, player)
        expect(valid_board.valid_moves).not_to include(1)
      end
    end

    context "when board is full" do
      let(:player) { instance_double(Computer, player_id: 1) }
      subject(:valid_board) { described_class.new(3, Array.new(3) { Array.new(3) { Cross.new(player) } }) }

      it "returns an array with length 0" do
        expect(valid_board.valid_moves.length).to eq(0)
      end
    end
  end

  describe "#valid?" do
    context "when not occupied" do
      subject(:valid_board) { described_class.new }

      it "returns true" do
        expect(valid_board).to be_valid(1)
      end
    end

    context "when occupied" do
      let(:player) { instance_double(Computer, player_id: 1) }
      subject(:valid_board) { described_class.new(3, Array.new(3) { Array.new(3) { Cross.new(player) } }) }

      it "returns false" do
        expect(valid_board).not_to be_valid(1)
      end
    end
  end

  describe "#clear" do
    let(:player) { instance_double(Computer, player_id: 1) }
    subject(:clear_board) { described_class.new(3, Array.new(3) { Array.new(3) { Cross.new(player) } }) }
    it "empties board" do
      expect(clear_board.clear).to all(all(be_nil))
    end
  end

  describe "#full?" do
    context "when the board is full" do
      let(:player) { instance_double(Computer, player_id: 1) }
      subject(:full_board) { described_class.new(3, Array.new(3) { Array.new(3) { Cross.new(player) } }) }
      it "returns true" do
        expect(full_board).to be_full
      end
    end
    context "when the board is not full" do
      subject(:empty_board) { described_class.new }
      it "returns false" do
        expect(empty_board).not_to be_full
      end
    end
  end

  describe "#winning_move?" do
    let(:winner) { instance_double(Computer, player_id: 1) }
    subject(:winning) { described_class.new }

    context "when the winning move is chosen" do
      before do
        allow(winning).to receive(:put_item).twice
        allow(winning).to receive(:over?).and_return(true)
      end
      it "returns true" do
        expect(winning.winning_move?(3, winner)).to be(true)
      end
    end
    context "when not the winning move is chosen" do
      before do
        allow(winning).to receive(:put_item).twice
        allow(winning).to receive(:over?).and_return(false)
      end
      it "returns false" do
        expect(winning.winning_move?(4, winner)).to be(false)
      end
    end
  end

  describe "#winning_move?" do
    let(:loser) { instance_double(Computer, player_id: 1) }
    subject(:losing) { described_class.new }

    context "when the losing move is chosen" do
      before do
        allow(losing).to receive(:put_item).twice
        allow(losing).to receive(:over?).and_return(true)
      end
      it "returns true" do
        expect(losing.losing_move?(3, loser)).to be(true)
      end
    end
    context "when not the losing move is chosen" do
      before do
        allow(losing).to receive(:put_item).twice
        allow(losing).to receive(:over?).and_return(false)
      end
      it "returns false" do
        expect(losing.losing_move?(4, loser)).to be(false)
      end
    end
  end
end
