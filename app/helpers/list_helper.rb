module ListHelper
  def list_price_range(list)
    if list.minimum_price == list.maximum_price
      number_to_currency list.minimum_price
    else
      "#{number_to_currency list.minimum_price} - #{number_to_currency list.maximum_price}"
    end
  end
end
