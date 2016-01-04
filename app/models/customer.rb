class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings, -> { where value: 4 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  def order_in_progress
    orders.where(state: 'in_progress').first
  end
end
