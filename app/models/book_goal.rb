class BookGoal < ApplicationRecord
  belongs_to :book
  scope :this_year, -> { where(year: DateTime.now.year) }
end
