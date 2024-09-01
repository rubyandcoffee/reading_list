# To run this job: $ BookGoalsStatusJob.perform_now
class BookGoalsStatusJob < ApplicationJob
  queue_as :default

  def perform
    current_year = DateTime.current.year.to_s
    current_month = Date::MONTHNAMES[DateTime.current.month]
    BookGoal.where(month: current_month, year: current_year).each do |goal|
      book = goal.book
      if book.status == 'unread'
        book.update_attribute(:status, 'tbr')
      end
    end
  end
end
