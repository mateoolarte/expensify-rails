require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "get index is successful" do
    get expenses_url
    assert_response :success
    assert_not_nil assigns(:expenses)
  end  

  # test "create a expense" do
  #   @expense = expenses :one

  #   assert_difference "Expense.count", 1 do
  #     post expenses_url, params: { expense: { options: @expense.options, concept: @expense.concept, date: @expense.date, amount: @expense.amount, category_id: @expense.category } }, xhr: true
  #   end
  # end  
end
