class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  belongs_to :series, optional: true
  has_many :book_transitions, autosave: false, dependent: :destroy
  has_many :book_goals, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :author_id, presence: true
  validates :genre_id, presence: true

  accepts_nested_attributes_for :book_goals, reject_if: ->(attributes){ attributes['book_id'].blank? }, allow_destroy: true

  delegate :can_transition_to?, :current_state, :history, :last_transition, :last_transition_to,
           :transition_to!, :transition_to, :in_state?, :allowed_transitions, to: :state_machine

  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: BookTransition,
    initial_state: :unread
  ]

  scope :current_state, -> (state) do
    if state == 'unread'
      # because "pending" won't exist in the database as it's the default state
      left_outer_joins(:book_transitions).where(book_transitions: {to_state: nil})
    else
      # else return all the requested "states" (but only the most recent)
      # most_recent: true is very important here for obvious reasons
      joins(:book_transitions).where(book_transitions: {most_recent: true}).where(book_transitions: {to_state: state})
    end
  end

  scope :long_books, -> { where('total_pages >= ?', 400) }
  scope :medium_books, -> { where('total_pages >= ? AND total_pages < ?', 200, 400) }
  scope :short_books, -> { where('total_pages < ?', 200) }

  def self.ransackable_scopes(auth_object = nil)
    ['current_state']
  end

  def self.ransackable_associations(auth_object = nil)
    ["author", "genre", "book_goal"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title", "total_pages"]
  end

  def state_machine
    @state_machine ||= BookStateMachine.new(self, transition_class: BookTransition, association_name: :book_transitions)
  end

  def status
    current_state.humanize
  end

  def short?
    total_pages && total_pages < 200
  end

  def medium?
    total_pages && total_pages >= 200 && total_pages < 400
  end

  def long?
    total_pages && total_pages >= 400
  end

  def length_in_words
    if long?
      'Long'
    elsif medium?
      'Medium'
    elsif short?
      'Short'
    else
      'Length undefined'
    end
  end

  def self.filter_by_length(length)
    books = Book.joins(:book_goals).where(book_goals: { year: DateTime.now.year })

    {
      'Short' => books.short_books,
      'Medium' => books.medium_books,
      'Long' => books.long_books
    }.fetch(length)
  end
end
