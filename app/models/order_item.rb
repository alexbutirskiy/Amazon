class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :price, presence: true

  before_validation :check_quantity

  def total_price
    price * quantity
  end

  private

  def check_quantity
    self.quantity = (quantity.to_i > 0) ? quantity.to_i : 0
  end
end
