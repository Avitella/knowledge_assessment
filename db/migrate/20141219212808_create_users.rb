class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login,    null: false
      t.string :password, null: false
      t.string :name,     null: false, default: ""
      t.string :surname,  null: false, default: ""
      t.string :group,    null: false, default: ""
      t.integer :teacher, null: false, default: 0

      t.timestamps
    end

    add_index :users, :login, unique: true
  end
end
