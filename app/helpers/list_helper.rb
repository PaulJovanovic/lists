module ListHelper
  def list_price_range(list)
    dollar_min = number_to_currency list.minimum_price, precision: 0
    dollar_max = number_to_currency list.maximum_price, precision: 0
    "<span class=\"js-list-minimum-price\">#{dollar_min}</span><span class=\"#{"hide " if dollar_min == dollar_max}js-list-price-range\"> - <span class=\"js-list-maximum-price\">#{dollar_max}</span></span>".html_safe
  end
end
