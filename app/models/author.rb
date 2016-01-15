class Author < ActiveRecord::Base
  has_many :book_authors
  has_many :books, through: :book_authors

  validates :firstname, presence: true
  validates :lastname, presence: true

  def name
    "#{firstname} #{lastname}"
  end
end
