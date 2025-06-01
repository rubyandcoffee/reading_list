require "application_system_test_case"

class BookGoalTimelinesTest < ApplicationSystemTestCase
  setup do
    @book_goal_timeline = book_goal_timelines(:one)
  end

  test "visiting the index" do
    visit book_goal_timelines_url
    assert_selector "h1", text: "Book goal timelines"
  end

  test "should create book goal timeline" do
    visit book_goal_timelines_url
    click_on "New book goal timeline"

    fill_in "Book goal", with: @book_goal_timeline.book_goal_id
    fill_in "Week four", with: @book_goal_timeline.week_four
    fill_in "Week one", with: @book_goal_timeline.week_one
    fill_in "Week three", with: @book_goal_timeline.week_three
    fill_in "Week two", with: @book_goal_timeline.week_two
    click_on "Create Book goal timeline"

    assert_text "Book goal timeline was successfully created"
    click_on "Back"
  end

  test "should update Book goal timeline" do
    visit book_goal_timeline_url(@book_goal_timeline)
    click_on "Edit this book goal timeline", match: :first

    fill_in "Book goal", with: @book_goal_timeline.book_goal_id
    fill_in "Week four", with: @book_goal_timeline.week_four
    fill_in "Week one", with: @book_goal_timeline.week_one
    fill_in "Week three", with: @book_goal_timeline.week_three
    fill_in "Week two", with: @book_goal_timeline.week_two
    click_on "Update Book goal timeline"

    assert_text "Book goal timeline was successfully updated"
    click_on "Back"
  end

  test "should destroy Book goal timeline" do
    visit book_goal_timeline_url(@book_goal_timeline)
    click_on "Destroy this book goal timeline", match: :first

    assert_text "Book goal timeline was successfully destroyed"
  end
end
