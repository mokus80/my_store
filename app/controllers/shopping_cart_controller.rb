class ShoppingCartController < ApplicationController


  ITEMS = [
    { 'Beer': { quantity: 0, price: 1.5 }},
    { 'Chips': { quantity: 0, price: 2.00 }},
    { 'Chocolate': { quantity: 0, price: 3.1 }},
    { 'Soda': { quantity: 0, price: 2.5 }},
    { 'Sandwich': { quantity: 0, price: 4.0 }}
  ]

  def new
    @items = ITEMS
  end

end
