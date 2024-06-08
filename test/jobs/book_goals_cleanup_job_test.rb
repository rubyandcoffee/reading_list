require "test_helper"

class BookGoalsCleanupJobTest < ActiveJob::TestCase
  test "remove goals that don't have a month" do
    assert_equal(BookGoal.count, 2)
    goal = book_goals(:goal_without_month)

    assert_performed_jobs 0
    assert_nil(goal.month)

    BookGoalsCleanupJob.perform_now

    assert_performed_jobs 1
    assert_equal(BookGoal.count, 1)
  end
end
