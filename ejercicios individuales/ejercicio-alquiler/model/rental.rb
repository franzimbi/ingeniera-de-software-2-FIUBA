PRICE_PER_HOUR = 99.0
PRICE_PER_DAY = 2001.0
PRICE_BASE_PER_KM = 100.0
PRICE_PER_KM = 10.0
BUSINESS_DISCOUNT = 0.05
FIRST_BUSINESS_DIGITS = 26
PROFIT_PERCENT = 0.45

class Rental
  # calculate recibe un type = ['h', 'd', 'k'], con data y cuit de tipo integrer.
  def calculate(type, data, cuit)
    total = calculate_total(type, data)
    total = apply_discount(total, cuit)
    revenue = calculate_revenue(total)
    [total.truncate(1), revenue.truncate(1)] # truncate para que devuelva solo 1
    #                                          digito sin redondear
  end

  private

  def calculate_total(type, data)
    total_map = {
      'h' => -> { PRICE_PER_HOUR * data },
      'd' => -> { PRICE_PER_DAY * data },
      'k' => -> { PRICE_BASE_PER_KM + PRICE_PER_KM * data }
    }
    total_map[type].call
  end

  def is_business_cuit(cuit)
    cuit_type = cuit.to_s.slice(0, 2).to_i # agarra los dos primeros digitos

    cuit_type == FIRST_BUSINESS_DIGITS
  end

  def apply_discount(price, cuit)
    return price * (1.0 - BUSINESS_DISCOUNT) if is_business_cuit(cuit)

    price
  end

  def calculate_revenue(total)
    total * PROFIT_PERCENT
  end
end
