require "rails_helper"

RSpec.describe CashRegister, :type => :model do

  RULES = [
    { buy: ['Sandwich', 'Chocolate'], buy_quantity: '1', freebie: 'Chocolate', freebie_quantity: '1', discount: nil, happy_hour: [] 
    },
    { buy: ['Chips'], buy_quantity: '3', freebie: 'Chips', freebie_quantity: '1', discount: nil, happy_hour: []
    },
    { buy: ['Soda'], buy_quantity: '1', freebie: nil, freebie_quantity: '1', discount: '20', happy_hour: [Time.now.hour, Time.now.hour + 1]
    }
  ]

  before do
    @register = CashRegister.new(RULES)
    @items = {"Beer"=>{"quantity"=>"4", "price"=>"6.0"}, "Soda"=>{"quantity"=>"3", "price"=>"7.5"}, "Sandwich"=>{"quantity"=>"3", "price"=>"9.0"}, "Chocolate"=>{"quantity"=>"2", "price"=>"6.2"}, "Chips"=>{"quantity"=>"1", "price"=>"2.0"}}
  end

  describe ".initialize" do
    it "has 3 rules" do
      expect(@register.rules.length).to eq(3)
    end
  end

  describe ".compute total" do
    it "returns '29.2'" do
      expect(@register.compute_total(@items)).to eq(29.2)
    end
  end

  describe "#apply_discount?" do
    it "returns true discount when given" do
      expect(CashRegister.apply_discount?(RULES.last)).to eq(true)
    end

    it "returns false when no discount given" do
      expect(CashRegister.apply_discount?(RULES.first)).to eq(false)
      expect(CashRegister.apply_discount?(RULES.first(2).last)).to eq(false)
    end
  end

  describe "#calculate factor" do
    it "returns 2 for first rule" do
      matches = RULES.first[:buy]
      expect(CashRegister.calculate_factor(matches, @items, RULES.first)).to eq(2)
    end
    it "returns nil for first rule" do
    	matches = RULES.first(2).last[:buy]
      expect(CashRegister.calculate_factor(matches, @items, RULES.first(2).last)).to eq(nil)
    end
    it "returns 3 for first rule" do
    	matches = RULES.last[:buy]
      expect(CashRegister.calculate_factor(matches, @items, RULES.last)).to eq(3)
    end
  end

  describe "#matches" do
    it "returns ['Chocolate', 'Sandwich']" do
      expect(CashRegister.matches(RULES.first, @items)).to eq(["Chocolate", "Sandwich"])
    end
  end

  describe "#add freebie" do
    it "adds two chocolates" do
      expect(CashRegister.add_freebie(RULES.first, @items, ["Chocolate", "Sandwich"])).to eq({"Beer"=>{"quantity"=>"4", "price"=>"6.0"}, "Soda"=>{"quantity"=>"3", "price"=>"7.5"}, "Sandwich"=>{"quantity"=>"3", "price"=>"9.0"}, "Chocolate"=>{"quantity"=>"4", "price"=>"6.2"}, "Chips"=>{"quantity"=>"1", "price"=>"2.0"}})
    end
  end

  describe "#happy hour?" do

   context "Happy Hour given" do
      it "returns true when current time is happy hour" do
        expect(CashRegister.happy_hour?([Time.now.hour, Time.now.hour + 1])).to eq(true)
      end

      it "returns false when current time is not happy hour" do
        expect(CashRegister.happy_hour?([Time.now.hour + 1, Time.now.hour + 2])).to eq(false)
      end
    end

    context "No Happy Hour given" do
      it "returns true when current time is happy hour" do
        expect(CashRegister.happy_hour?([])).to eq(false)
      end

    end
    
  end

  describe "#apply discount" do
    it "return '6.0' for 3 Sodas during Happy Hour" do
      expect(CashRegister.apply_discount(RULES.last, @items, ["Soda"])).to eq("6.0")
    end
  end

  describe ".total" do
    it "returns" do
      expect(@register.total(@items)).to eq(30.7)
    end
  end

end