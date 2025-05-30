class Book < ApplicationRecord
  belongs_to :author
  belongs_to :series, optional: true
  has_many :book_goals, dependent: :destroy
  has_and_belongs_to_many :genres
  has_one :rental, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :author_id, presence: true
  validates :genres, presence: true

  accepts_nested_attributes_for :book_goals, allow_destroy: true
  accepts_nested_attributes_for :rental, allow_destroy: true, reject_if: :all_blank

  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :unrated, -> { where(status: 'read', rating: nil).or(where(status: 'dnf', rating: nil)) }
  scope :read, -> { where(status: 'read') }
  scope :unread, -> { where(status: 'unread') }

  STATUSES = %w[unread read dnf reading]
  PAGE_LIMITS = { short: 200, medium: 400 }.freeze

  def self.ransackable_associations(auth_object = nil)
    %w[author genres book_goal]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title total_pages status]
  end

  def short?
    total_pages&.< PAGE_LIMITS[:short]
  end

  def medium?
    (total_pages&.>= PAGE_LIMITS[:short]) && (total_pages < PAGE_LIMITS[:medium])
  end

  def long?
    total_pages&.>= PAGE_LIMITS[:medium]
  end

  def length_in_words
    case
    when long?
      'Long'
    when medium?
      'Medium'
    when short?
      'Short'
    else
      'Length undefined'
    end
  end

  def self.filter_by_length(length)
    {
      'Short' => where('total_pages < ?', PAGE_LIMITS[:short]),
      'Medium' => where('total_pages >= ? AND total_pages < ?', PAGE_LIMITS[:short], PAGE_LIMITS[:medium]),
      'Long' => where('total_pages >= ?', PAGE_LIMITS[:medium])
    }.fetch(length)
  end

  def read?
    status == 'read'
  end

  def dnf?
    status == 'dnf'
  end

  def self.tbr
    Book
      .joins(:book_goals)
      .where(book_goals: { month: Time.now.strftime("%B"), year: Time.now.year} )
      .and(where(status: 'unread'))
  end
end
