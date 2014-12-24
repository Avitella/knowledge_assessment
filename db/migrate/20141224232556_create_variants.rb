class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.references :test
      t.integer    :number,  null: false
      t.references :question

      t.timestamps
    end

    add_index :variants, [:test_id, :number, :question_id], unique: true
  end
end
