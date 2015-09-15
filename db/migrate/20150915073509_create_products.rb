class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
