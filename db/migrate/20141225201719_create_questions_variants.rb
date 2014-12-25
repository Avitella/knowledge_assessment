class CreateQuestionsVariants < ActiveRecord::Migration
  def change
    create_table :questions_variants, id: false do |t|
      t.references :variant
      t.references :question

      t.timestamps
    end

    add_index :questions_variants, [:variant_id, :question_id], unique: true
  end
end
