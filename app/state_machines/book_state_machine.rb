class BookStateMachine
  include Statesman::Machine

  state :unread, initial: true  # Not read yet
  state :buy                    # To buy
  state :tbr                    # To be read
  state :reading                # Currently reading
  state :dnf                    # Did not finish
  state :read                   # Already read

  transition from: :unread,       to: [:tbr, :reading, :buy, :dnf, :read]
  transition from: :buy,          to: [:tbr, :reading, :unread, :dnf, :read]
  transition from: :tbr,          to: [:unread, :reading, :buy, :dnf, :read]
  transition from: :reading,      to: [:tbr, :unread, :buy, :dnf, :read]
  transition from: :dnf,          to: [:tbr, :reading, :buy, :unread, :read]
  transition from: :read,         to: [:tbr, :reading, :buy, :dnf, :unread]

  guard_transition(to: :tbr) do |order|
    Book.in_state(:tbr).count < 10
  end

  guard_transition(to: :reading) do |order|
    Book.in_state(:reading).count < 1
  end
end