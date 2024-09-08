class Rental < ApplicationRecord
  belongs_to :book
  belongs_to :loaner
  validates :loaner, presence: true
  before_validation :set_default_loaner

  private

  def set_default_loaner
    self.loaner ||= Loaner.default_loaner
  end
end
