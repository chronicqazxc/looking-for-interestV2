class CreateMinorTypes < ActiveRecord::Migration
  def change
    create_table :minor_types do |t|
      t.text :type_description
      
      t.belongs_to :major_type, index: true

      t.timestamps null: false
    end
  end
end
