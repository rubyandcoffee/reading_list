module BooksHelper
  def state_klass(book)
    if state_klasses.include?(book.status)
      state_klasses.fetch(book.status)
    else
      'hidden'
    end
  end

  def checkbox_icon(book)
    checkbox_klasses.fetch(book.status)
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
    total = series.books.where(status: 'read').count + series.books.where(status: 'dnf').count
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
      'read' => 'bg-success',
      'tbr' => 'bg-warning',
      'reading' => 'bg-primary',
      'unread' => 'bg-info',
      'dnf' => 'bg-primary'
    }
  end

  def checkbox_klasses
    {
      'read' => 'fa-regular fa-square-check',
      'dnf' => 'fa-solid fa-poo',
      'tbr' => 'fa-regular fa-square',
      'reading' => 'fa-regular fa-square',
      'unread' => 'fa-regular fa-square'
    }
  end
end
