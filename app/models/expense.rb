class Expense < ApplicationRecord
  belongs_to :category

  scope :expenses_six_months, -> { where( date: (DateTime.now.months_ago(6).beginning_of_month)..DateTime.now) }

  # def self.probando
  #   expenses_six_months = Expense.where( date: ((DateTime.now.months_ago(6).beginning_of_month)..DateTime.now))
  #   data_chart = []

  #   def build_data_months(option, data_month)
  #   end
  #   data_values = []

  #   expense_type_name = expenses_six_months.where("options = ?", "Compra")

  #   expense_type_name.find_each do |expense|
  #     data_values.push({ x: expense.amount, y: "new Date(2017, 1)" })
  #   end  

  #   return data_values

  #   build_data_months()

  #   expenses_six_months.find_each do |expense|
  #     if expense.options == "Compra"        
  #       values_purchase = {
  #         color: "#1e88e5",
  #         name: expense.options,
  #         showInLegend: true,
  #         type: "stackedColumn",
  #         date: expense.date,
  #         amount: expense.amount
  #       }
  #       data_chart.push(values_purchase)
  #     elsif expense.options == "Retiro"
  #       values_withdrawal = {
  #         color: expense.options == "Compra" ? "#1e88e5" : expense.options == "Retiro" ? "#e53935" : expense.options == "Transferencia" ? "#8e24aa" : "#43a047",
  #         name: expense.options,
  #         showInLegend: true,
  #         type: "stackedColumn",
  #         date: expense.date,
  #         amount: expense.amount
  #       }
  #       data_chart.push(values_withdrawal)
  #     end
  #   end 
  # end
end
