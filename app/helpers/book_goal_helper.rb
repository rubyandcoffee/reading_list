module BookGoalHelper
  def time_to_read(book)
    return unless book.total_pages.present?

    in_minutes = book.total_pages * 1.5
    in_hours = (in_minutes / 60).round
  end
end