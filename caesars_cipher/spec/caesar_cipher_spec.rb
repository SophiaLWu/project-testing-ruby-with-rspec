require "caesar_cipher"

describe "caesar_cipher" do

  context "given an empty string" do
    it "returns an empty string" do
      expect(caesar_cipher("", 5)).to eql("")
    end
  end

  context "given 'a' and a shift factor of 3" do
    it "returns 'd'" do
      expect(caesar_cipher("a",3)).to eql("d")
    end
  end

  context "given 'A' and a shift factor of 26" do
    it "returns 'A'" do
      expect(caesar_cipher("A",26)).to eql("A")
    end
  end

  context "given 'a' and a shift factor of 27" do
    it "wraps around and returns 'b'" do
      expect(caesar_cipher("a",27)).to eql("b")
    end
  end

  context "given 'B' and a shift factor of -7" do
    it "wraps around and returns 'U'" do
      expect(caesar_cipher("B",-7)).to eql("U")
    end
  end

  context "given 'what a string' and a shift factor of 5" do
    it "returns 'bmfy f xywnsl'" do
      expect(caesar_cipher("what a string",5)).to eql("bmfy f xywnsl")
    end
  end

  context "given 'GooD morNINg' and a shift factor of 20" do
    it "returns 'AiiX gilHCHa'" do
      expect(caesar_cipher("GooD morNINg",20)).to eql("AiiX gilHCHa")
    end
  end

  context "given 'Hello there, my fine chap!' and a shift factor of -10" do
    it "returns 'Xubbe jxuhu, co vydu sxqf!'" do
      expect(caesar_cipher("Hello there, my fine chap!",-10)).to \
      eql("Xubbe jxuhu, co vydu sxqf!")
    end
  end

end