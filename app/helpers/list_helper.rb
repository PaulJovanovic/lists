module ListHelper
  def list_price_range(list)
    dollar_min = number_to_currency list.minimum_price, precision: 0
    dollar_max = number_to_currency list.maximum_price, precision: 0
    "<span class=\"js-list-minimum-price\">#{dollar_min}</span><span class=\"#{"hide " if dollar_min == dollar_max}js-list-price-range\"> - <span class=\"js-list-maximum-price\">#{dollar_max}</span></span>".html_safe
  end

  def list_display_row_size(lists_count)
    case lists_count
    when 1
      3
    when 2
      6
    when 4, 8
      12
    end
  end

  def list_display_column_size(lists_count)
    case lists_count
    when 1
      12
    when 2
      6
    when 4, 8
      3
    end
  end
end
