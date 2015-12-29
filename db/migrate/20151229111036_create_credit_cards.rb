class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :CVV
      t.integer :expiration_month
      t.integer :expiration_year
      t.string :firstname
      t.string :lastname
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
