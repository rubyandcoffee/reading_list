class AddTotalPagesToBooks < ActiveRecord::Migration[7.0]
  def self.up
    add_column :books, :total_pages, :integer
    remove_column :books, :length
  end

  def self.down
    add_column :books, :length, :string

    Book.find_each do |book|
      if book.total_pages >= 400
        book.update_attribute(:length, 'Long')
      elsif book.total_pages < 200
        book.update_attribute(:length, 'Short')
      else
        book.update_attribute(:length, 'Medium')
      end
    end

    remove_column :books, :total_pages
  end
end
