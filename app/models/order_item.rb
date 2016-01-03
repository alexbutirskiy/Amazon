class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :price, presence: true
  validates :quantity, presence: true
end
