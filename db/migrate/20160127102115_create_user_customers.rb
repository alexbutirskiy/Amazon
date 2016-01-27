class CreateUserCustomers < ActiveRecord::Migration
  def change
    create_table :user_customers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
