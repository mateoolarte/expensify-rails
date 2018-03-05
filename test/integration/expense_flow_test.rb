require 'test_helper'

class ExpenseFlowTest < Capybara::Rails::TestCase
  def setup
    @one = expenses :one
    @two = expenses :two
  end

  test 'expenses index' do
    visit expenses_path

    assert page.has_content?(@one.options)
    assert page.has_content?(@two.options)
  end
end