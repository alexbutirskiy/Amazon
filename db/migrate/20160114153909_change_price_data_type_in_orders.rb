class ChangePriceDataTypeInOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.change :total_price, :decimal, precision: 6, scale: 2
    end
  end
end
