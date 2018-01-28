require "rails_helper"

RSpec.describe ShoppingCart, :type => :model do

  before do
    items = {"Beer"=>{"quantity"=>"4", "price"=>"1.5"}, "Chips"=>{"quantity"=>"0", "price"=>"2.0"}, "Chocolate"=>{"quantity"=>"0", "price"=>"3.1"}, "Soda"=>{"quantity"=>"3", "price"=>"2.5"}, "Sandwich"=>{"quantity"=>"2", "price"=>"4.0"}}
    @cart = ShoppingCart.new(items)
  end

  describe ".initialize" do
    it "has 5 items" do
      expect(@cart.items.length).to eq(5)
    end
  end

  describe ".purchased" do
    it "excludes " do
      expect(@cart.purchased).to eq(
        {"Beer"=>{"quantity"=>"4", "price"=>"6.0"}, "Soda"=>{"quantity"=>"3", "price"=>"7.5"}, "Sandwich"=>{"quantity"=>"2", "price"=>"8.0"}}
        )
    end
  end

  describe ".update prices" do
    it "multiplies price with quantity" do
      items = {"Beer"=>{"quantity"=>"4", "price"=>"1.5"}, "Soda"=>{"quantity"=>"3", "price"=>"2.5"}, "Sandwich"=>{"quantity"=>"2", "price"=>"4.0"}}
      expect(@cart.class.update_prices(items)).to eq(
        {"Beer"=>{"quantity"=>"4", "price"=>"6.0"}, "Soda"=>{"quantity"=>"3", "price"=>"7.5"}, "Sandwich"=>{"quantity"=>"2", "price"=>"8.0"}}
        )
    end
  end
end