class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings, -> { where value: 4 }

  validates :firstname, presence: true
  validates :lastname, presence: true

  def order_in_progress
    orders.where(state: 'in_progress').first
  end
end
