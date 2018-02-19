module ExpensesHelper
  def get_average_per_month(data)
    average = data.count
    total = 0
    data.each do |expense|
      total += expense.amount
    end
    average != 0 ? average = total / average : 0
  end

  def get_total_amount_per_month(data)
    total = 0
    data.each do |expense|
      total += expense.amount
    end
    total
  end
end
