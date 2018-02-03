# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Categories of Expenses
Category.create(name: "Restaurantes")
Category.create(name: "Comida")
Category.create(name: "Carro")
Category.create(name: "Servicios")
Category.create(name: "Casa")
Category.create(name: "Educacion")
Category.create(name: "Diversion")
Category.create(name: "Viajes")

require 'faker'

# Expenses
number_of_expenses = 1000

number_of_expenses.times do |index|
  Expense.create({
    options: (index <= (number_of_expenses / 4).floor) ? "Compra" : (index <= (number_of_expenses / 2).floor) ? "Retiro" : (index <= (number_of_expenses / 1.33).floor) ? "Transferencia" : "Pago", 
    concept: Faker::Commerce.product_name, 
    date: Faker::Time.between(DateTime.now.prev_year().beginning_of_month, DateTime.now), 
    amount: Faker::Number.decimal(6, 2), 
    category_id: Faker::Number.between(1, 8)
  })
end
