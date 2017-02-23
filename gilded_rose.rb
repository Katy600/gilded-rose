class GildedRose
  def initialize(item)
    @items = item
    @items_past_their_sell_by_date = []
    @items_within_their_sell_by_date = []
  end

  def update_quality()
    sort_items_by_sell_by_date
    update_quality_within_sell_by_date
    update_quality_past_sell_by_date
  end

  def sort_items_by_sell_by_date
    @items.each do |item|
      item.sell_in <= 0 ? (@items_past_their_sell_by_date << item) : (@items_within_their_sell_by_date << item)
    end
  end

  def update_quality_within_sell_by_date
    @items_within_their_sell_by_date.each { |item| (item.sell_in -= 1) && (item.quality -= 1)}
    prevent_quality_from_going_below_zero(@items_within_their_sell_by_date)
  end

  def update_quality_past_sell_by_date
    @items_past_their_sell_by_date.each { |item|(item.sell_in -= 1) && (item.quality -= 2)}
    prevent_quality_from_going_below_zero(@items_past_their_sell_by_date)
  end

  def prevent_quality_from_going_below_zero(items)
    @items = items
    @items.map {|item| item.quality = 0 if item.quality <= 0 && item.sell_in <= 0}
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
