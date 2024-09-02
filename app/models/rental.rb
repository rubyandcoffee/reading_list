class Rental < ApplicationRecord
  acts_as_paranoid # This is only needed because Book has acts_as_paranoid
  belongs_to :book
  belongs_to :loaner
  validates :loaner, presence: true
end
