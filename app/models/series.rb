class Series < ApplicationRecord
  belongs_to :author
  has_many :books

  def self.completed?(series)
    books_in_series = series.books.count
    total = series.books.where(status: 'read').count + series.books.where(status: 'dnf').count
    total == books_in_series
  end
end
