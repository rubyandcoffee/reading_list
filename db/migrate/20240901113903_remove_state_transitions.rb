class RemoveStateTransitions < ActiveRecord::Migration[7.0]
  def change
    BookTransition.transaction do
      book_transitions = BookTransition.includes(:book).all
      book_transitions.where(most_recent: false).destroy_all

      book_transitions.each do |transition|
        book = Book.find(transition.book_id)
        book.status = transition.to_state
        book.save!
        transition.destroy!
      end
    end

    drop_table :book_transitions
  end
end
