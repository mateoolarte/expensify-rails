class Expense < ApplicationRecord
  belongs_to :category

  validates :concept, :date, :amount, :options, presence: true

  scope :expenses_six_months, -> { where( date: (DateTime.now.months_ago(6).beginning_of_month)..DateTime.now) }
  scope :month_ago, -> (month_ago = 0) { where(date: DateTime.now.months_ago(month_ago.to_i).beginning_of_month..DateTime.now.months_ago(month_ago.to_i).end_of_month).order(date: :desc) }
  scope :type, -> (type) { where("options ILIKE ?", "%#{type}%")  }
  scope :category, -> (category) { where("category_id = ?", category) }
  
  def self.get_options
    expenses = self.all
    arr_options = []

    expenses.each { |expense| arr_options << expense.options unless arr_options.include? expense.options }

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

    array_temp_months.each_with_index { |v, i| months_last_year << { i => "#{v}" } }

    months_last_year
  end
end
