class BookStateMachine
  include Statesman::Machine

  state :unread, initial: true  # Not read yet
  state :yearly_goal            # TBR this year
  state :buy                    # To buy
  state :tbr                    # To be read
  state :reading                # Currently reading
  state :dnf                    # Did not finish
  state :read                   # Already read

  transition from: :unread,       to: [:tbr, :reading, :buy, :yearly_goal]
  transition from: :yearly_goal,  to: [:unread, :tbr, :reading]
  transition from: :buy,          to: [:unread, :tbr, :reading, :yearly_goal]
  transition from: :tbr,          to: [:reading, :unread, :read, :yearly_goal]
  transition from: :reading,      to: [:tbr, :read, :dnf] 
  transition from: :dnf,          to: [:tbr, :reading]
  transition from: :read,         to: [:tbr, :reading]

  guard_transition(to: :tbr) do |order|
    Book.in_state(:tbr).count < 10
  end

  guard_transition(to: :reading) do |order|
    Book.in_state(:reading).count < 1
  end
end