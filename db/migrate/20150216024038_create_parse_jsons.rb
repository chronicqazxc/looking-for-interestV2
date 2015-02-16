class CreateParseJsons < ActiveRecord::Migration
  def change
    create_table :parse_jsons do |t|
      t.string :name
      t.string :address, unique: true

      t.belongs_to :major_type, index: true
      t.belongs_to :minor_type, index: true

      t.timestamps null: false
    end
  end
end
