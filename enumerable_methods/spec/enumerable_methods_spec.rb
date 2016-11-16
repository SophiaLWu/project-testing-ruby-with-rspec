require "enumerable_methods"

describe Enumerable do
  describe "#my_select" do
    context "given an empty array and a block" do
      it "returns an empty array" do
        expect([].my_select { |x| x < 2 }).to eql([])
      end
    end

    context "given [1,2,3] and no block" do
      it "returns the enumerator object" do
        expect([1,2,3].my_select.class).to eql(Enumerator)
      end
    end

    context "given an empty hash and a block" do
      it "returns an empty hash" do
        expect({}.my_select { |k,v| v < 0 }).to eql({})
      end
    end

    context "given [1,2,3,4,5,6] and a block to select for all evens" do
      it "returns [2,4,6]" do
        expect([1,2,3,4,5,6].my_select { |x| x % 2 == 0 }).to eql([2,4,6])
      end
    end

    context "given ['a','b','c'] and a block that selects for all strings" do
      it "returns ['a','b','c']" do
        expect(["a","b","c"].my_select \
          { |x| x.is_a? String }).to eql(["a","b","c"])
      end
    end

    context "given [1,3,5,7,9] and a block that selects for evens" do
      it "returns an empty array" do
        expect([1,3,5,7,9].my_select { |x| x % 2 == 0 }).to eql([])
      end
    end

    context "given {a: 2, b: 3, c: 6} and a block that selects for values "\
            "that are even" do
      it "returns {a: 2, c: 6}" do
        expect({a: 2, b: 3, c: 6}.my_select \
          { |k,v| v % 2 == 0 }).to eql({a: 2, c: 6})
      end
    end

    context "given {'apple' => 2, 'banana' => 3, 'carrot' => 6} and a block "\
            "that selects for even values and keys that begin with a" do
      it "returns {'apple' => 2}" do
        expect({"apple" => 2, "banana" => 3, "carrot" => 6}.my_select \
          { |k,v| v % 2 == 0 && k.start_with?("a") }).to eql({"apple" => 2})
      end
    end

  end
end