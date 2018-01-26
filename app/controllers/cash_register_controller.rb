class CashRegisterController < ApplicationController

  def create
    puts params
    @shopping_cart = ShoppingCart.new(params)
    @purchased_items = @shopping_cart.purchased
    @register = CashRegister.new
    @total = @register.compute_total(@purchased_items)

    render json: @total
  end
end