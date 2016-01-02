class Order < ActiveRecord::Base
  IN_PROGRESS = 'in_progress'
  COMPLETED = 'completed'
  SHIIPED = 'shipped'
  STATES = [IN_PROGRESS, COMPLETED, SHIIPED]

  belongs_to :customer
  belongs_to :credit_card
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'

  validates :total_price, presence: true
  validates :completed_date, presence: true
  validates :state, presence: true

  validate :check_state

  after_initialize :set_state

  private

  def set_state
    self.state ||= IN_PROGRESS
  end

  def check_state
    unless STATES.include?(self.state)
      errors.add(:state, "state '#{self.state}' is not allowed")
    end
  end
end
