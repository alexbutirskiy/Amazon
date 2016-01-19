class AddFullDescriptionToBooks < ActiveRecord::Migration
  def change
    add_column :books, :full_description, :text
  end
end
