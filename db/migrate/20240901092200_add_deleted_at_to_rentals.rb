class AddDeletedAtToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :deleted_at, :datetime
    add_index :rentals, :deleted_at
  end
end
