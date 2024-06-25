class Rental < ApplicationRecord
  belongs_to :book

  scope :outstanding, -> { where('return_date IS NULL') }
end
