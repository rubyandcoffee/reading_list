class AddYearlyGoalToBooks < ActiveRecord::Migration[7.0]
  def self.up
    add_column :books, :yearly_goal, :string

    book_transitions = BookTransition.where(to_state: 'yearly_goal')

    book_transitions.each do |transition|
      transition.update_attribute(:to_state, 'unread')
      transition.book.update_attribute(:yearly_goal, DateTime.now.year)
    end
  end

  def self.down
    books = Book.where.not(yearly_goal: nil)

    books.includes(:book_transitions).each do |book|
      book.last_transition.update_attribute(:to_state, 'yearly_goal')
    end

    remove_column :books, :yearly_goal
  end
end
