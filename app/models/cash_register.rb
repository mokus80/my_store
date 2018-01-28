class CashRegister

  attr_accessor :rules

  def initialize(rules)
    @rules = rules
  end

  def compute_total(items)
    self.rules.each do |rule|
      rule = rule.stringify_keys
      matches = CashRegister.matches(rule, items)
 
      if matches.present?

        if CashRegister.apply_discount?(rule)
          CashRegister.apply_discount(rule, items, matches)
        end
       
        if rule['freebie']
          CashRegister.add_freebie(rule, items, matches)
        end
      end
    end
    total(items)
  end

  def self.apply_discount?(rule)
    rule = rule.stringify_keys
    (rule['happy_hour'].present? && !rule['discount'].nil? && happy_hour?(rule['happy_hour'])) || (rule['happy_hour'].blank? && !rule['discount'].nil? && !happy_hour?(rule['happy_hour']))
  end

  def self.calculate_factor(matches, items, rule)
    rule = rule.stringify_keys
    matches.map do |match|
      if items[match]['quantity'].to_i > rule['buy_quantity'].to_i && rule['buy_quantity'].to_i > 0
      (items[match]['quantity'].to_i / rule['buy_quantity'].to_i)
      else
        nil
      end

    end.min
  end

  def self.matches(rule, items)
    rule = rule.stringify_keys
    match = items.keys & rule['buy']
    match && match.sort == rule['buy'].sort ? match.sort : []
  end

  def self.add_freebie(rule, items, matches)
    rule = rule.stringify_keys
    factor = CashRegister.calculate_factor(matches, items, rule)
    if items[rule['freebie']] && factor
      items[rule['freebie']] = { 'quantity': (rule['freebie_quantity'].to_i * factor + items[rule['freebie']]['quantity'].to_i).to_s, 'price': (0 + items[rule['freebie']]['price'].to_f).to_s }.stringify_keys
    elsif factor
      items[rule['freebie']] = { 'quantity': (rule['freebie_quantity'].to_i * factor).to_s, 'price': '0' }.stringify_keys
    end
    items
  end 

  def self.happy_hour?(times)
    return false unless times.present?
    Time.now.hour >= times.first && Time.now.hour < times.last
  end

  def self.apply_discount(rule, items, matches)
    rule = rule.stringify_keys

    factor = CashRegister.calculate_factor(matches, items, rule)

    per_item = items[rule['buy'].first]["price"].to_f / items[rule['buy'].first]["quantity"].to_i

    discounted = factor * rule['buy_quantity'].to_i

    dis_price = discounted * per_item
    
    dis_price = dis_price - ( rule['discount'].to_f / 100 * dis_price )

    reg_price = per_item * (items[rule['buy'].first]["quantity"].to_i - discounted)

    items[rule['buy'].first]["price"] = (dis_price + reg_price).to_s
  end

  def total(items)
    items.map {|k,v|  v['price'].to_f}.compact.inject(:+)
  end

end
