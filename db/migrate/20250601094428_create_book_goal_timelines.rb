class CreateBookGoalTimelines < ActiveRecord::Migration[7.0]
  def change
    create_table :book_goal_timelines do |t|
      t.references :book_goal, null: false, foreign_key: true
      t.integer :week_one
      t.integer :week_two
      t.integer :week_three
      t.integer :week_four

      t.timestamps
    end
  end
end
