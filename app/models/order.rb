class Order < ActiveRecord::Base
  include AASM

  belongs_to :customer
  belongs_to :credit_card
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  has_many :order_items, dependent: :destroy

  validates :total_price, presence: true, unless: :new_record?
  validates :completed_date, presence: true, if: :completed?

  before_save :update_total_price

  def add_book(book, quantity = 1)
    save if new_record?
    order_items.create(book: book, quantity: quantity.to_i, price: book.price)
    update_total_price
  end

  aasm column: :state do
    state :cart, initial: true
    state :wait_addresses
    state :wait_delivery
    state :wait_payment
    state :confirming
    state :delivering
    state :completed

    event :checkout do
      transitions from: [ :cart, :wait_addresses, :wait_delivery, 
                          :wait_payment],
                  to: :wait_addresses
    end

    event :set_addresses do
      transitions from: [:wait_addresses, :wait_delivery, :wait_payment], 
      to: :wait_delivery
    end

    event :set_delivery do
      transitions from: [:wait_delivery, :wait_payment], to: :wait_payment
    end

    event :set_payment do
      transitions from: [:wait_payment, :confirming], to: :confirming
    end

    event :confirmed do
      transitions from: :confirming, to: :delivering
    end

    event :delivered do
      transitions from: :delivering, to: :completed
    end
  end

  private

  def update_total_price
    self.total_price = order_items.inject(0) do |sum, item|
      sum + item.quantity * item.book.price
    end
  end
end
