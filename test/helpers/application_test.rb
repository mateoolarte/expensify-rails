require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @categories = Category.all
  end  

  test "get_categories" do
    assert_equal @categories, get_categories
  end
end