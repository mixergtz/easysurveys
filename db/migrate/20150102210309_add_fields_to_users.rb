class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :genre, :integer, default: 0
    add_column :users, :birth_date, :date
  end
end
