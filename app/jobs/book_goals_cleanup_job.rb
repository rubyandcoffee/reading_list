# To run this job: $ BookGoalsCleanupJob.perform_now
class BookGoalsCleanupJob < ApplicationJob
  queue_as :default

  def perform
    BookGoal.all.each do |goal|
      goal.destroy unless goal.month.present?
    end
  end
end
