class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :store_id
      t.integer :rate
      t.text :content
      t.string :guest_name

      t.timestamps null: false
    end
  end
end
