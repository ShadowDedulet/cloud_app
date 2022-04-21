class Prices
  PRICES = {}

  def self.add_price(price_data)
    type = price_data[0]
    raise ArgumentError, "Price for unit #{type} already exists" if PRICES.key?(type.to_sym)

    PRICES[type.to_sym] = price_data[1].to_i
  end

  def self.find_by_type(type)
    PRICES[type]
  end
end
