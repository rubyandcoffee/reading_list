module BooksHelper
  def stale?(book)
    book.book_transitions.last.created_at < 1.month.ago
  end
end
