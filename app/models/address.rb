class Address < ActiveRecord::Base
  validates :address, presence: true
  validates :zipcode, presence: true
  validates :city, presence: true
  validates :phone, presence: true
  validates :country, presence: true

  def orders
    Order.where(
      'billing_address_id = ? OR shipping_address_id = ?', 
      self.id, self.id)
  end
end
