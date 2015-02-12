class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, unique: true, index: true
      t.string :email, unique: true, index: true
      t.string :password_digest
      t.string :session_token, unique: true
      
      t.timestamps null: false
    end
  end
end
