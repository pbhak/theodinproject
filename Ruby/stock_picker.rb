def stock_picker(prices)
  all_possible_values = []
  profit = 0
  result = [];

  prices.each_with_index do |x_value, x_index|
    prices.each_with_index do |y_value, y_index|
      all_possible_values << [x_value, y_value] if x_index > y_index
    end
  end

  all_possible_values.each do |profit_value|
    break if profit == prices.max - prices.min;
    if profit_value[0] - profit_value[1] > profit
      profit = profit_value[0] - profit_value[1]
      result[1] = prices.index(profit_value[0])
      result[0] = prices.index(profit_value[1])
    end
  end

result
end

p stock_picker([17,3,6,9,15,8,6,1,10])
