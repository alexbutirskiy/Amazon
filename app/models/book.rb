class Book < ActiveRecord::Base
  has_many :book_authors
  has_many :authors, through: :book_authors
  belongs_to :category

  after_initialize :set_defaults, if: :new_record?

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :in_stock, numericality: { greater_than_or_equal_to: 0 }
  validates :sold, numericality: { greater_than_or_equal_to: 0 }

  scope :in_stock, -> { where('in_stock > 0') }
  scope :out_of_stock, -> { where('in_stock = 0') }
  scope :bestsellers, -> { order(sold: :desc) }

  private

  def set_defaults
    self.in_stock ||= 0
    self.sold ||= 0
  end
end
