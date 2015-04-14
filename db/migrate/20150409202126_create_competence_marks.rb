class CreateCompetenceMarks < ActiveRecord::Migration
  def change
    create_table :competence_marks, id: false do |t|
      t.references :result,     index: true
      t.references :competence, index: true
      t.integer :mark,          null: false,  default: 0

      t.timestamps
    end
  end
end
