class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  belongs_to :series
  has_many :book_transitions, autosave: false, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :author_id, presence: true
  validates :genre_id, presence: true

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

  def self.ransackable_scopes(auth_object = nil)
    ['current_state']
  end

  def self.ransackable_associations(auth_object = nil)
    ["author", "genre"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  def state_machine
    @state_machine ||= BookStateMachine.new(self, transition_class: BookTransition, association_name: :book_transitions)
  end

  def status
    current_state.humanize
  end
end
