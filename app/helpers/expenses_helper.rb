module ExpensesHelper
  def get_average_per_month(data)
    average = data.count
    amount = 0
    data.each do |expense|
      amount += expense.amount
    end
    average != 0 ? average = amount / average : 0
  end

  def get_total_amount_per_month(data)
    total = 0
    data.each do |expense|
      total += expense.amount
    end
    total
  end
end
