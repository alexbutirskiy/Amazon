class ChangePriceDataTypeInBooks < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.change :price, :decimal, precision: 6, scale: 2
    end
  end
end
