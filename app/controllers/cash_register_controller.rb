class CashRegisterController < ApplicationController

  RULES = [
    { buy: ['Chocolate'], buy_quantity: '1', freebie: 'Chocolate', freebie_quantity: '1', discount: nil, happy_hour: [] },
    { buy: ['Beer'], buy_quantity: '3', freebie: nil, freebie_quantity: nil, discount: '10' , happy_hour: [] },
    { buy: ['Sandwich', 'Soda'], buy_quantity: '1', freebie: 'Chocolate', freebie_quantity: '1', discount: nil, happy_hour: [] },
    { buy: ['Beer'], buy_quantity: '1', freebie: nil, freebie_quantity: nil, discount: '50', happy_hour: [17, 19] },
    { buy: ['Soda'], buy_quantity: '1', freebie: nil, freebie_quantity: nil, discount: '50', happy_hour: [17, 19] }
  ]

  def create
    @cart = ShoppingCart.new(params["items"].to_unsafe_h)
    @purchased_items = @cart.purchased
    @register = CashRegister.new(RULES)
    @total = @register.compute_total(@purchased_items)
  end

  def index
    redirect_to root_path
  end

end