
# All items have a SellIn value which denotes the number of days we have to sell the item
# 	- All items have a Quality value which denotes how valuable the item is
# 	- At the end of each day our system lowers both values for every item

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "decreases the sell_in value by 1" do
      items = [Item.new("foo", 5, 10)]
      expect {GildedRose.new(items).update_quality()}.to change {items[0].sell_in}.by(-1)
    end

    it "decreases the quality value by 1" do
      items = [Item.new("foo", 5, 10)]
      expect {GildedRose.new(items).update_quality()}.to change {items[0].quality}.by(-1)
    end

    it "decreases the quality value by 2 after sell-by-date has passed" do
      items = [Item.new("foo", 0, 10)]
      expect {GildedRose.new(items).update_quality()}.to change {items[0].quality}.by(-2)
    end

    it "'s quality never goes below zero when sell-by-date has passed" do
      items = [Item.new("foo", 0, 0)]
      expect {GildedRose.new(items).update_quality()}.to change {items[0].quality}.by(0)
    end

    it " 'Aged Brie' actually increases in Quality the older it gets" do
      items = [Item.new("Aged Brie", 0, 10)]
      expect {GildedRose.new(items).update_quality()}.to change {items[0].quality}.by(2)
    end
    # it "never increases in quality beyond 50" do
    #
    # end

  end

  describe Item do
    it 'has a sellin value' do
      item = Item.new('item', 5, 5)
      expect(item.sell_in).to eq(5)
    end

    it 'has a quality value' do
      item = Item.new('item', 5, 5)
      expect(item.quality).to eq(5)
    end
  end
end
