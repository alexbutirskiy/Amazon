class AddShippingAddressToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :shipping_address, index: true, foreign_key: true
  end
end
