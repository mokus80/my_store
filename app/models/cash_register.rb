class CashRegister

  attr_accessor :rules

  def initialize(rules)
    @rules = rules
  end

  def compute_total(items)
    self.rules.each do |rule|
      matches = items.keys & rule[:buy]
 
      if self.class.matches(rule, items)
        
        factor = self.class.calculate_factor(matches, items, rule)

        if self.class.apply_discount?(rule)
          self.class.apply_discount(rule, items, factor)
        end
       
        if rule[:freebie]
          self.class.add_freebie(items, rule, factor)
        end
      end
    end
    total(items)
  end

  def self.apply_discount?(rule)
    (rule[:happy_hour].present? && !rule[:discount].nil? && happy_hour?(rule[:happy_hour])) || (rule[:happy_hour].blank? && !rule[:discount].nil? && !happy_hour?(rule[:happy_hour]))
  end

  def self.calculate_factor(matches, items, rule)
    matches.map do |match|
      (items[match][:quantity].to_f / rule[:buy_quantity].to_i).to_i
    end.min
  end

  def self.matches(rule, items)
    match = items.keys & rule[:buy]
    match && match.sort == rule[:buy].sort
  end

  def self.add_freebie(items, rule, factor)
    items[rule[:freebie]] = { 'quantity': (rule[:freebie_quantity].to_i * factor).to_s, 'price': '0' }
  end 

  def self.happy_hour?(times)
    return false unless times.present?
    Time.now.hour >= times.first && Time.now.hour < times.last
  end

  def self.apply_discount(rule, items, factor)
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
