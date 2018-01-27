class CashRegister
  include ActiveModel::Model

  attr_accessor :items

  RULES = [
    { buy: ['Chocolate'], buy_quantity: '1', freebie: 'Chocolate', freebie_quantity: '1', discount: nil, happy_hour: [] },
    { buy: ['Beer'], buy_quantity: '3', freebie: nil, freebie_quantity: nil, discount: '10' , happy_hour: [] },
    { buy: ['Sandwich', 'Soda'], buy_quantity: '1', freebie: 'Chocolate', freebie_quantity: '1', discount: nil, happy_hour: [] },
    { buy: ['Beer'], buy_quantity: '1', freebie: nil, freebie_quantity: nil, discount: '50', happy_hour: [17, 19] },
    { buy: ['Soda'], buy_quantity: '1', freebie: nil, freebie_quantity: nil, discount: '50', happy_hour: [17, 19] }
  ]

  def initialize
    @rules = RULES
  end

  def compute_total(items)
    @rules.each do |rule|
      matches = items.keys & rule[:buy]
 
      if matches(rule, items)
        
        factor = calculate_factor(matches, items, rule)

        if apply_discount?(rule)
          apply_discount(rule, items, factor)
        end
       
        if rule[:freebie]
          add_freebie(items, rule, factor)
        end
      end
    end
    total(items)
  end

  def apply_discount?(rule)
    (rule[:happy_hour].present? && !rule[:discount].nil? && happy_hour?(rule[:happy_hour])) || (rule[:happy_hour].blank? && !rule[:discount].nil? && !happy_hour?(rule[:happy_hour]))
  end

  def calculate_factor(matches, items, rule)
    matches.map do |match|
      (items[match][:quantity].to_f / rule[:buy_quantity].to_i).to_i
    end.min
  end

  def matches(rule, items)
    match = items.keys & rule[:buy]
    match && match.sort == rule[:buy].sort
  end

  def add_freebie(items, rule, factor)
    items[rule[:freebie]] = { 'quantity': (rule[:freebie_quantity].to_i * factor).to_s, 'price': '0' }
  end 

  def happy_hour?(times)
    return false unless times.present?
    Time.now.hour >= times.first && Time.now.hour < times.last
  end

  def apply_discount(rule, items, factor)
    per_item = items[rule[:buy].first]["price"].to_f / items[rule[:buy].first]["quantity"].to_i

    discounted = factor * rule[:buy_quantity].to_i

    dis_price = discounted * per_item
    
    dis_price = dis_price - ( rule[:discount].to_f / 100 * dis_price )

    reg_price = per_item * (items[rule[:buy].first]["quantity"].to_i - discounted)

    items[rule[:buy].first]["price"] = (dis_price + reg_price).to_s
  end

  def total(items)
    items.map {|k,v|  v['price'].to_f}.compact.inject(:+)
  end

end
