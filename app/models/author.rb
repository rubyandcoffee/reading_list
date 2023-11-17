class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["forename", "surname"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["books"]
  end

  def full_name
    forename + ' ' + surname
  end
end
