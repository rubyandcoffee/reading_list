module ApplicationHelper
  def currently_reading
    Book.where(status: 'reading')
  end
end
