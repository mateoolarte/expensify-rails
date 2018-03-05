require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "get index is successful" do
    get expenses_url
    assert_response :success
    assert_not_nil assigns(:expenses)
  end  
end
