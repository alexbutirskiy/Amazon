class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings,  -> { where value: 4 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  def new_order
    Order.new(customer_id: self.id)
  end

  def order_in_progress
    self.orders.where(state: 'in_progress').first
  end
end
