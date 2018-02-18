class Expense < ApplicationRecord
  belongs_to :category

  validates :concept, :date, :amount, :options, presence: true
  validates :amount, numericality: true

  scope :expenses_six_months, -> { where( date: (DateTime.now.months_ago(6).beginning_of_month)..DateTime.now) }

  def get_date_dropdown
    self.date.strftime("%B %Y")
  end
  
  def self.get_options
    expenses = self.all
    arr_options = []
    expenses.each do |expense|
      arr_options << expense.options unless arr_options.include? expense.options
    end  
    arr_options
  end

  def self.get_months_last_year
    months = self.where(date: (DateTime.now.prev_year.beginning_of_month)..DateTime.now).order(date: :desc)
    months_last_year = []
    array_temp_months = []
    months.each do |month|
      year_and_month = month.date.strftime("%B %Y")
      array_temp_months << year_and_month unless array_temp_months.include? year_and_month
    end  

    array_temp_months.each_with_index do |v, i|
      months_last_year << { i => "#{v}" }
    end
    months_last_year
  end

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
