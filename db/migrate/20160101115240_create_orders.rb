class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :total_price
      t.date :completed_date
      t.string :state
      t.references :customer, index: true, foreign_key: true
      t.references :credit_card, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
