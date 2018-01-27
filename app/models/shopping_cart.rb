class ShoppingCart

	attr_accessor :items

  def initialize(items = {})
    @items = items
  end

  def purchased
    items = self.items.select {|k,v| !v['quantity'].to_i.zero?}
    self.class.update_prices(items)
  end

  def self.update_prices(items)
    items.each do |k, v|
      v['price'] = v['price'].to_f * v['quantity'].to_f
    end
  end
end