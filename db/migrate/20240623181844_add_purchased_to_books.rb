class AddPurchasedToBooks < ActiveRecord::Migration[7.0]
  def self.up
    add_column :books, :purchased, :boolean, default: true

    book_transitions = BookTransition.where(to_state: 'buy', most_recent: true)

    book_transitions.each do |transition|
      book = transition.book
      book.transition_to('unread')
      book.update_attribute(:purchased, false)
    end
  end

  def self.down
    Book.where(purchased: false).each do |book|
      book.transition_to('buy')
    end

    remove_column :books, :purchased
  end
end
