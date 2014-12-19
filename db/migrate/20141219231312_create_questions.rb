class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text,          null: false, default: ""
      t.integer :difficulty, null: false, default: 0
      t.references :topic,   index: true

      t.timestamps
    end
  end
end
