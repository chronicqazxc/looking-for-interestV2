class CreateMinorTypes < ActiveRecord::Migration
  def change
    create_table :minor_types do |t|
      t.string :type_id
      t.text :type_description
      t.string :major_type_id
      t.timestamps null: false
    end
  end
end
