class CreateBookGoals < ActiveRecord::Migration[7.0]
  def self.up
    create_table :book_goals do |t|
      t.string :month
      t.string :year
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    Book.find_each do |book|
      BookGoal.create(book: book, month: book.monthly_goal, year: book.yearly_goal)
    end

    remove_column :books, :monthly_goal
    remove_column :books, :yearly_goal
  end

  def self.down
    BookGoal.find_each do |goal|
      Book.update(goal.book.id, monthly_goal: goal.month, yearly_goal: goal.year)
    end

    drop_table :book_goals
  end
end
