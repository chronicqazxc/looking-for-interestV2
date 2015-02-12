class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :store_id
      t.string :name
      t.string :phone_number
      t.string :city
      t.text :address
      t.string :major_type_id
      t.string :minor_type_id
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
