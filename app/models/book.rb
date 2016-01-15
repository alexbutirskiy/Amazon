class Book < ActiveRecord::Base
  has_many :book_authors
  has_many :authors, through: :book_authors
  belongs_to :category

  before_validation :check_in_stock

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :in_stock, numericality: { greater_than_or_equal_to: 0 }

  scope :in_stock, -> { where('in_stock > 0') }
  scope :out_of_stock, -> { where('in_stock = 0') }

  private

  def check_in_stock
    self.in_stock ||= 0
  end
end
