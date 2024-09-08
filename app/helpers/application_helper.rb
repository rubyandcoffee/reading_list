module ApplicationHelper
  def currently_reading
    Book.where(status: 'reading').last
  end
end
