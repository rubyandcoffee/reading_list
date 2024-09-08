class Book < ApplicationRecord
  belongs_to :author
  belongs_to :series, optional: true
  has_many :book_goals, dependent: :destroy
  has_and_belongs_to_many :genres
  has_one :rental, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :author_id, presence: true

  accepts_nested_attributes_for :book_goals, allow_destroy: true
  accepts_nested_attributes_for :rental, allow_destroy: true, reject_if: :all_blank

  scope :long_books, -> { where('total_pages >= ?', 400) }
  scope :medium_books, -> { where('total_pages >= ? AND total_pages < ?', 200, 400) }
  scope :short_books, -> { where('total_pages < ?', 200) }

  scope :not_deleted, -> { where(deleted_at: nil) }

  STATUSES = %w[unread read dnf reading tbr]

  def self.ransackable_associations(auth_object = nil)
    %w[author genres book_goal]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title total_pages status]
  end

  def short?
    total_pages && total_pages < 200
  end

  def medium?
    total_pages && total_pages >= 200 && total_pages < 400
  end

  def long?
    total_pages && total_pages >= 400
  end

  def length_in_words
    if long?
      'Long'
    elsif medium?
      'Medium'
    elsif short?
      'Short'
    else
      'Length undefined'
    end
  end

  def self.filter_by_length(length)
    {
      'Short' => books.short_books,
      'Medium' => books.medium_books,
      'Long' => books.long_books
    }.fetch(length)
  end
end
