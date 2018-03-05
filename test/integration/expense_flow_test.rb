require 'test_helper'

class ExpenseFlowTest < ActionDispatch::IntegrationTest
  
  def setup
    @one = expenses :one
    @two = expenses :two
    Capybara.current_driver = Capybara.javascript_driver
  end

  test 'expenses index' do
    visit expenses_path

    assert page.has_content?(@one.options)
    assert page.has_content?(@two.options)
  end

  test "creates an expense" do
    visit "/expenses"

    click_link "Nuevo gasto"
    page.must_have_css("#expense-modal")

    fill_in "Concept", with: "Compra de zapatos"
    fill_in "Amount", with: 200000
    click_button "Crear gasto"


    page.must_have_content "fue creado exitosamente"
    page.must_have_content "Compra de zapatos"
  end
end