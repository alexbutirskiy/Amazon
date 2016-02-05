class Customer < ActiveRecord::Base
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  has_many :orders
  has_many :reviews
  has_one :user_customer, dependent: :destroy
  has_one :site_account, through: :user_customer

  validates :firstname, presence: true
  validates :lastname, presence: true

  def order_in_progress
    orders.where(state: 'cart').first
  end

  def name
    firstname + ' ' + lastname
  end
end
