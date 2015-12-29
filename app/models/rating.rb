class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :customer

  validates :value, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10 }
end
