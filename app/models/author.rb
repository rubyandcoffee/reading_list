class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :nationality, :gender, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["forename", "gender", "nationality", "surname"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["books"]
  end

  def self.nationalities
    Nationality::Nationality.default_option("british")
  end

  def full_name
    forename + ' ' + surname
  end
end
