class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :phone_number
      t.string :city
      t.text :address
      t.float :latitude
      t.float :longitude
      
      t.belongs_to :major_type, index: true
      t.belongs_to :minor_type, index: true

      t.timestamps null: false
    end
  end
end
