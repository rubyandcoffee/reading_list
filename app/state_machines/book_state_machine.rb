class BookStateMachine
  include Statesman::Machine

  state :unread, initial: true  # Not read yet
  state :tbr                    # To be read
  state :reading                # Currently reading
  state :dnf                    # Did not finish
  state :read                   # Already read

  transition from: :unread,       to: [:tbr, :reading, :dnf, :read]
  transition from: :tbr,          to: [:unread, :reading, :dnf, :read]
  transition from: :reading,      to: [:tbr, :unread, :dnf, :read]
  transition from: :dnf,          to: [:tbr, :reading, :unread, :read]
  transition from: :read,         to: [:tbr, :reading, :dnf, :unread]

  guard_transition(to: :tbr) do |order|
    Book.in_state(:tbr).count < 10
  end

  guard_transition(to: :reading) do |order|
    Book.in_state(:reading).count < 1
  end
end