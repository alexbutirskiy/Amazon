class Order < ActiveRecord::Base
  include AASM
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
  has_many :order_items, dependent: :destroy

  validates :total_price, presence: true, unless: :new_record?
  validates :completed_date, presence: true, if: :completed?

  before_save :update_total_price

  # TODO What should we do if book price changes durign order?
  def add_book(book, quantity = 1)
    save if new_record?
    order_items.create(book: book, quantity: quantity.to_i, price: book.price)
    update_total_price
  end

  aasm column: :state do
    state :cart, initial: true
    state :wait_addresses
    state :wait_delivery_methd
    state :wait_payment
    state :wait_confirm
    state :wait_deliverence_confirmation
    state :completed

    event :checkout do
      transitions from: [ :cart, :wait_addresses, :wait_delivery_methd, 
                          :wait_payment, :wait_confirm ],
                  to: :wait_addresses
    end

    event :set_addresses do
      transitions from: :wait_addresses, 
      to: :wait_delivery_methd
    end

    event :set_delivery_method do
      transitions from: :wait_delivery_methd, to: :wait_payment
    end
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
