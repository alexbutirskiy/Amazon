class ChangePriceDataTypeInOrderItems < ActiveRecord::Migration
  def change
    change_table :order_items do |t|
      t.change :price, :decimal, precision: 6, scale: 2
    end
  end
end
