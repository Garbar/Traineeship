class AddProToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pro, :boolean, :default => false, :null => false
    add_column :products, :name_shop, :string
  end
end
