class Author < ApplicationRecord
  has_many :books

  def full_name
    forename + ' ' + surname
  end
end
