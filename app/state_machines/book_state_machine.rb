class BookStateMachine
  include Statesman::Machine

  state :unread, initial: true  # Not read yet
  state :tbr                    # To be read
  state :reading                # Currently reading
  state :dnf                    # Did not finish
  state :read                   # Already read

  transition from: :unread,       to: [:tbr, :reading]
  transition from: :tbr,          to: [:reading, :unread, :read]        
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