class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :text,       null: false, default: ""
      t.integer :parent_id

      t.timestamps
    end

    add_index :topics, :parent_id
  end
end
