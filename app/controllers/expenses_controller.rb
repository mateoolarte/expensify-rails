class ExpensesController < ApplicationController
  before_action :find_expense, only: [:edit, :update, :destroy]
  before_action :get_expenses_per_month, only: [:index, :create, :update, :destroy]

  def index
    @tab = :expenses
    
    @dropdown_date = @expenses.first
    
    if params[:month_ago].present?
      @expenses = Expense.month_ago(params[:month_ago]) 
      @dropdown_date = @expenses.first
    end  
    
    @expenses = @expenses.type(params[:type]) if params[:type].present?
    
    @expenses = @expenses.category(params[:category]) if params[:category].present?

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
      @expenses = Expense.month_ago
    end
end
