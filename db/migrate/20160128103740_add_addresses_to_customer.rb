class AddAddressesToCustomer < ActiveRecord::Migration
  def change
    add_reference :customers, :billing_address, index: true
    add_reference :customers, :shipping_address, index: true
    add_foreign_key :customers, :addresses, column: :billing_address_id
    add_foreign_key :customers, :addresses, column: :shipping_address_id
  end
end
