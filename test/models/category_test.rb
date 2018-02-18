require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "category should have a name" do
    @category = Category.new
    assert_not @category.save
  end 

  test "category has many expenses" do
    assert_equal 1, categories(:one).expenses.size
  end 
end
