require "spec_helper"

module ConnectFour
  describe Player do

    describe "#initialize" do
      it "raises an error when initialized without arguments" do
        expect{ Player.new }.to raise_error(ArgumentError)
      end

      it "does not raise an error when initialized with a name and color" do
        expect{ Player.new("Jane", "red") }.to_not raise_error
      end
    end

    let(:player) { Player.new("Jane", "red") }

    describe "#color" do
      it "returns the color piece that the player plays as" do
        expect(player.color).to eql("red")
      end
    end

    describe "#name" do
      it "returns the name of the player" do
        expect(player.name).to eql("Jane")
      end
    end

  end
end
