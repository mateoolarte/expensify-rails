require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  test "should not save expense empty" do
    expense = Expense.new
    assert_not expense.save
  end
 
  test "get_options" do
    options = Expense.get_options
    assert_equal ["Compra", "Retiro", "Transferencia"], options
  end  
end
