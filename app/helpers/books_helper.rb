module BooksHelper
  def stale?(book)
    book.book_transitions.last.created_at < 1.month.ago
  end

  def state_klass(book)
    if state_klasses.include?(book.current_state)
      state_klasses.fetch(book.current_state)
    else
      'hidden'
    end
  end

  def length_klass(book)
    if book.short?
      'light'
    elsif book.medium?
      'secondary'
    elsif book.long?
      'dark'
    else
      'light'
    end
  end

  def completed_series?(series)
    books_in_series = series.books.count
    total = series.books.current_state('read').count + series.books.current_state('dnf').count
    total == books_in_series
  end

  def time_to_read(book)
    return unless book.total_pages.present?

    in_minutes = book.total_pages * 1.5
    in_hours = (in_minutes / 60).round
  end

  private

  def state_klasses
    {
      'buy' => 'bg-danger',
      'read' => 'bg-success',
      'tbr' => 'bg-warning',
      'reading' => 'bg-primary',
      'unread' => 'bg-info'
    }
  end
end
