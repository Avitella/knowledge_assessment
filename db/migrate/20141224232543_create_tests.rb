class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.text :text,       null: false
      t.integer :enabled, null: false, default: 0

      t.timestamps
    end
  end
end
