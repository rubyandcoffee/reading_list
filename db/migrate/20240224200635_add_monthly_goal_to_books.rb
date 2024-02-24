class AddMonthlyGoalToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :monthly_goal, :string
  end
end
