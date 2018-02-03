class ExpensesController < ApplicationController
  def index
    @tab = :expenses

    @categories = Category.all
    @dropdown_date = Expense.where(date: DateTime.now.all_month).first
    @expenses_last_year = Expense.get_months_last_year
    @expenses_options = Expense.get_options
    @expenses_per_month = Expense.where(date: DateTime.now.all_month).order(date: :desc)
    
    if params[:month_ago].present?
      @dropdown_date = Expense.where(date: DateTime.now.months_ago(params[:month_ago].to_i).all_month).first
      @expenses_per_month = Expense.where(date: DateTime.now.months_ago(params[:month_ago].to_i).beginning_of_month..DateTime.now.months_ago(params[:month_ago].to_i).end_of_month).order(date: :desc)
    end
    
    if params[:type].present?
      @expenses_per_month = @expenses_per_month.where("options ILIKE ?", "%#{params[:type]}%") 
    end
    
    if params[:category].present?
      @expenses_per_month = @expenses_per_month.where("category_id = ?", params[:category])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @expense = Expense.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @expense = Expense.create(expense_params)
  end

  def update
    @expense = Expense.find(params[:id])
    @expense.update(expense_params)
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
  end

  private
    def expense_params
      params.require(:expense).permit(:options, :concept, :date, :amount, :category_id)
    end
end
