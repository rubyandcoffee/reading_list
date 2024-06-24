class Rental < ApplicationRecord
  belongs_to :book

  scope :outstanding, -> { where('returned_date IS NULL') }
end
