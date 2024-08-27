require "./lib/items/item"
require "./lib/players/player"

describe Item do
  describe "::item_type" do
    context "when converting player 0" do
      let(:random_player) { instance_double(Player, player_id: 0) }
      it "returns Cross class" do
        result = described_class.item_type(random_player)
        expect(result.class).to eq(Cross)
      end
    end
    context "when converting player 1" do
      let(:random_player) { instance_double(Player, player_id: 1) }
      it "returns Circle class" do
        result = described_class.item_type(random_player)
        expect(result.class).to eq(Circle)
      end
    end
    context "when converting another player" do
      let(:random_player) { instance_double(Player, player_id: 3) }
      it "returns nil" do
        result = described_class.item_type(random_player)
        expect(result).to be_nil
      end
    end
  end
end
