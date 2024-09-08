class RemoveDeletedAtFromRentals < ActiveRecord::Migration[7.0]
  def change
    remove_column :rentals, :deleted_at, :datetime
  end
end
