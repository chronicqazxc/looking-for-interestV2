class CreateMajorTypes < ActiveRecord::Migration
  def change
    create_table :major_types do |t|
      t.string :type_id
      t.text :type_description

      t.timestamps null: false
    end
  end
end
