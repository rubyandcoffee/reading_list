module ApplicationHelper
  def currently_reading
    Book.in_state(:reading).first
  end
end
