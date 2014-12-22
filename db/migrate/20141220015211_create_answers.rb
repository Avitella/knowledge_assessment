class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text,           null: false, default: ""
      t.integer :correct,     null: false, default: 0
      t.references :question, index: true

      t.timestamps
    end
  end
end
