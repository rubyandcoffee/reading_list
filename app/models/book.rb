class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
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

  def state_machine
    @state_machine ||= BookStateMachine.new(self, transition_class: BookTransition, association_name: :book_transitions)
  end

  def status
    current_state.humanize
  end
end
