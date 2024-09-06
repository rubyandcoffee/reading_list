class Loaner < ApplicationRecord
  has_many :rentals

  def self.default_loaner
    Loaner.first
  end
end
