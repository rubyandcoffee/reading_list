class BookGoal < ApplicationRecord
  acts_as_paranoid
  belongs_to :book
  scope :this_year, -> { where(year: DateTime.now.year) }
end
