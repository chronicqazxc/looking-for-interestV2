class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :rate
      t.text :content
      t.string :guest_name
      
      t.belongs_to :store, index: true

      t.timestamps null: false
    end
  end
end
