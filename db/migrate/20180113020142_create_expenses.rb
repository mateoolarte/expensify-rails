class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :type
      t.string :concept
      t.date :date
      t.decimal :amount
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
