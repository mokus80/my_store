require "rails_helper"

RSpec.describe CashRegister, :type => :model do

  RULES = [
    { buy: ['Sandwich', 'Chocolate'], buy_quantity: '1', freebie: 'Chocolate', freebie_quantity: '1', discount: nil, happy_hour: [] 
    },
    { buy: ['Chips'], buy_quantity: '3', freebie: '1', freebie_quantity: '1', discount: nil, happy_hour: []
    },
    { buy: ['Soda'], buy_quantity: '1', freebie: nil, freebie_quantity: '1', discount: '20', happy_hour: [10, 20]
    }
  ]

  before do
    @register = CashRegister.new(RULES)
  end

  describe ".initialize" do
    it "has 3 rules" do
      expect(@register.rules.length).to eq(3)
    end
  end

  describe ".compute total" do
    it "" do
      
    end
  end

  describe "#apply_discount" do
    it "" do
      
    end
  end

  describe "#calculate factor" do
    it "" do
      
    end
  end

  describe "#matches" do
    it "" do
      
    end
  end

  describe "#add freebie" do
    it "" do
      
    end
  end

  describe "#happy hour?" do
    it "" do
      
    end
  end

  describe "#apply discount" do
    it "" do
      
    end
  end

  describe ".total" do
    it "" do
      
    end
  end

end