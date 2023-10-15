class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  def full_name
    forename + ' ' + surname
  end
end
