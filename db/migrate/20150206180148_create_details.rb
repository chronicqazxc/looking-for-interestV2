class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :open_time
      t.text :introduction
      t.string :icon_url
      t.string :image_url_1
      t.string :image_url_2
      t.string :image_url_3
      t.string :web_address
      t.integer :total_rate
      t.float :average_rate
      
      t.belongs_to :store, index: true

      t.timestamps null: false
    end
  end
end
