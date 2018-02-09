class ExpensesController < ApplicationController
  before_action :find_expense, only: [:edit, :update, :destroy]
  before_action :get_expenses_per_month, only: [:index, :create, :update, :destroy]

  def index
    @tab = :expenses

    @dropdown_date = Expense.where(date: DateTime.now.all_month).first
    @expenses_last_year = Expense.get_months_last_year
    @expenses_options = Expense.get_options
    
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
  end

  def create
    @expense = Expense.create(expense_params)
    flash[:success] = @expense
  end

  def edit
  end

  def update
    @expense.update(expense_params)
    flash[:updated] = "El gasto ha sido actualizado con éxito" 
  end

  def destroy
    @expense.destroy
    flash[:delete] = @expense
  end

  private
    def expense_params
      params.require(:expense).permit(:options, :concept, :date, :amount, :category_id)
    end

    def find_expense
      @expense = Expense.find(params[:id])
    end

    def get_expenses_per_month
      @expenses_per_month = Expense.where(date: DateTime.now.all_month).order(date: :desc)
    end
end
