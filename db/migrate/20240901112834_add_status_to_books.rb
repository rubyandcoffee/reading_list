class AddStatusToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :status, :string, default: 'unread'
  end
end
