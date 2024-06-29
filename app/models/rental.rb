class Rental < ApplicationRecord
  belongs_to :book
  belongs_to :loaner

  scope :outstanding, -> { where('return_date IS NULL') }
end
