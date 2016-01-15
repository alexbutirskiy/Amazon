class Order < ActiveRecord::Base
  class States
    IN_PROGRESS = 'in_progress'
    COMPLETED = 'completed'
    SHIIPED = 'shipped'

    def self.all
      constants.map { |c| const_get(c) }
    end
  end

  belongs_to :customer
  belongs_to :credit_card
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  has_many :order_items

  validates :total_price, presence: true
  validates :completed_date, presence: true
  validates :state, 
    inclusion: { in: States.all, 
      message: "is wrong, only #{States.all} states are allowed" }

  before_validation :set_state
  before_save :update_total_price

  # TODO What should we do if book price changes durign order?
  def add_book(book, quantity = 1)
    price = book.price * quantity
    order_items.create(book: book, quantity: quantity, price: price)
    update_total_price
  end

  private

  def set_state
    self.state ||= States::IN_PROGRESS
  end

  def update_total_price
    self.total_price = order_items.inject(0) do |sum, item|
      sum + item.quantity * item.book.price
    end
  end
end
