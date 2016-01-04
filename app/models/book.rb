class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category

  before_validation :check_in_stock

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :in_stock, numericality: { greater_than_or_equal_to: 0 }

  validate :check_price

  scope :in_stock, -> { where('in_stock > 0') }
  scope :out_of_stock, -> { where('in_stock = 0') }

  private

  def check_in_stock
    self.in_stock ||= 0
  end

  def check_price
    return if price && price.round(2) == price
    errors.add(:price, 'in cents is not an integer')
  end
end
