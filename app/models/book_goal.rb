class BookGoal < ApplicationRecord
  belongs_to :book
  has_one :timeline, class_name: 'BookGoalTimeline', dependent: :destroy
  scope :this_year, -> { where(year: DateTime.now.year) }
end
