
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

    it '(the quality) is never more than 50' do
      items = [Item.new("Aged Brie", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it '"Sulfuras", being a legendary item, never has to be sold or decreases in quality' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 40)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 40
    end

    it " 'Backstage passes' increases in quality by 2 when there are 10 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      expect {GildedRose.new(items).update_quality()}.to change {items[0].quality}.by(2)
    end

    it " 'Backstage passes' increases in quality by 3 when there are 5 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
      expect {GildedRose.new(items).update_quality()}.to change {items[0].quality}.by(3)
    end

    it " 'Backstage passes' quality drops to 0 after the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
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
