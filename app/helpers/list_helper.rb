module ListHelper
  def list_price_range(list)
    dollar_min = number_to_currency list.minimum_price, precision: 0
    dollar_max = number_to_currency list.maximum_price, precision: 0
    if dollar_min == dollar_max
      dollar_min
    else
      "#{dollar_min} - #{dollar_max}"
    end
  end
end
