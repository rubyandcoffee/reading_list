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
    series.books.map(&:current_state).all?('read')
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
