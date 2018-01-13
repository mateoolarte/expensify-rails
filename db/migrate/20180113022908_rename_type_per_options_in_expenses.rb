class RenameTypePerOptionsInExpenses < ActiveRecord::Migration[5.1]
  def change
    rename_column :expenses, :type, :options
  end
end
