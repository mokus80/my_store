class ShoppingCart

	attr_accessor :items

  def initialize(params = {})
    @items = params['items'].to_unsafe_h
  end

  def purchased
    @items = @items.select {|k,v| !v['quantity'].to_i.zero?}
    update_prices(@items)
  end

  def update_prices(items)
    items.each do |k, v|
      v['price'] = v['price'].to_f * v['quantity'].to_f
    end
  end
end