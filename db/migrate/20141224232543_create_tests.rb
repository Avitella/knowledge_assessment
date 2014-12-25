class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.text    :text,            null: false
      t.integer :on,              null: false, default: 0
      t.integer :variants_count,  null: false, default: 0
      t.integer :questions_count, null: false, default: 0

      t.timestamps
    end
  end
end
