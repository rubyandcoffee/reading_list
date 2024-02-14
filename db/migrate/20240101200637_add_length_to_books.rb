class AddLengthToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :length, :string
  end
end
