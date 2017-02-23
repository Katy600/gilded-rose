class GildedRose

  def initialize(item)
    @items = item
    @items_past_their_sell_by_date = []
    @items_within_their_sell_by_date = []
  end

  def update_quality()
    sort_item_by_sell_by_date
    update_quality_within_sell_by_date
    update_quality_past_sell_by_date
  end

  def sort_items_by_sell_by_date
    @items.each do |item|
      if item.sell_in <= 0
        @items_past_their_sell_by_date << item
      else
        @items_within_their_sell_by_date << item
      end
    end
  end

  def update_quality_within_sell_by_date
    @items_within_their_sell_by_date.each { |item| (item.sell_in -= 1) && (item.quality -= 1)}
  end

  def update_quality_past_sell_by_date
      @items_past_their_sell_by_date.each { |item|(item.sell_in -= 1) && (item.quality -= 2)}
  end
end


class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
