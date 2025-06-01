class Rental < ApplicationRecord
  belongs_to :book
  belongs_to :loaner
  validates :loaner, presence: true
  validates :book, presence: true
end
