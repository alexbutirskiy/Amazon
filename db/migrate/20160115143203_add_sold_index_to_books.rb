class AddSoldIndexToBooks < ActiveRecord::Migration
  def change
    add_index :books, :sold
  end
end
