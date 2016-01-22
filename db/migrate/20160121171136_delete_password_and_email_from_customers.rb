class DeletePasswordAndEmailFromCustomers < ActiveRecord::Migration
  def change
    change_table :customers do |t|
      t.remove :password, :email
    end
  end
end
