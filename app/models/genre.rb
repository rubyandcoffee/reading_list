class Genre < ApplicationRecord
  has_many :books

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["books"]
  end
end
