class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings, -> { where value: 4 }
  has_one :user_customer, dependent: :destroy
  has_one :site_account, through: :user_customer

  validates :firstname, presence: true
  validates :lastname, presence: true

  def order_in_progress
    orders.where(state: 'in_progress').first
  end
end
