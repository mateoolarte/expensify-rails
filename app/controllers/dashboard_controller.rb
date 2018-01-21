class DashboardController < ApplicationController
  def index
    @tab = :dashboard
    @expenses_six_months = Expense.expenses_six_months
    @categories = Category.all
  end
end
