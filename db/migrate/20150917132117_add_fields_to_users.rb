class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :surname, :string
    add_column :users, :shop_name, :string
    add_column :users, :role, :integer
    add_column :users, :avatar, :string
    add_column :users, :passport, :string
    add_column :users, :date_birth, :datetime
  end
end
