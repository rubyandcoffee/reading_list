class AddDueDateToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :due_date, :date
  end
end
