class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :price, presence: true
  validates :quantity, presence: true

  def total_price
    price * quantity
  end
end
