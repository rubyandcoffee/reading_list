require "test_helper"

class BookGoalTimelinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_goal_timeline = book_goal_timelines(:one)
  end

  test "should get index" do
    get book_goal_timelines_url
    assert_response :success
  end

  test "should get new" do
    get new_book_goal_timeline_url
    assert_response :success
  end

  test "should create book_goal_timeline" do
    assert_difference("BookGoalTimeline.count") do
      post book_goal_timelines_url, params: { book_goal_timeline: { book_goal_id: @book_goal_timeline.book_goal_id, week_four: @book_goal_timeline.week_four, week_one: @book_goal_timeline.week_one, week_three: @book_goal_timeline.week_three, week_two: @book_goal_timeline.week_two } }
    end

    assert_redirected_to book_goal_timeline_url(BookGoalTimeline.last)
  end

  test "should show book_goal_timeline" do
    get book_goal_timeline_url(@book_goal_timeline)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_goal_timeline_url(@book_goal_timeline)
    assert_response :success
  end

  test "should update book_goal_timeline" do
    patch book_goal_timeline_url(@book_goal_timeline), params: { book_goal_timeline: { book_goal_id: @book_goal_timeline.book_goal_id, week_four: @book_goal_timeline.week_four, week_one: @book_goal_timeline.week_one, week_three: @book_goal_timeline.week_three, week_two: @book_goal_timeline.week_two } }
    assert_redirected_to book_goal_timeline_url(@book_goal_timeline)
  end

  test "should destroy book_goal_timeline" do
    assert_difference("BookGoalTimeline.count", -1) do
      delete book_goal_timeline_url(@book_goal_timeline)
    end

    assert_redirected_to book_goal_timelines_url
  end
end
