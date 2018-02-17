require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  test "should not save expense empty" do
    expense = Expense.new
    assert_not expense.save
  end 

  test "concept should have five words" do
    expense = Expense.new(concept: expenses(:one).concept)
    assert_not expense.save
  end  

  test "amount should be a number" do
    @expense = Expense.new(amount: "string")
    assert_not @expense.save
  end  
end
