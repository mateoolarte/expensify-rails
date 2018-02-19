class Api::V1::ExpensesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @expenses = Expense.all

    @expenses = @expenses.paginate(:page => params[:page], :per_page => 50) if params[:page].present?

    @expenses = @expenses.type(params[:options]) if params[:options].present?
       
    @expenses = @expenses.category(params[:category_id]) if params[:category_id].present?

    render json: @expenses
  end

  def create
    expense = Expense.new(expense_params)
    if expense.save
      render json: expense
    else
      render json: { errors: expense.errors }, status: 422
    end
  end

  def update
    expense = Expense.find(params[:id])
    expense.update(expense_params)
    head :no_content
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    head :no_content
  end

  private
    def expense_params
      params.permit(:options, :concept, :date, :amount, :category_id)
    end
end