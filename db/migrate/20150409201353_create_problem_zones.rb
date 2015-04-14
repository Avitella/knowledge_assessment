class CreateProblemZones < ActiveRecord::Migration
  def change
    create_table :problem_zones, id: false do |t|
      t.references :result, index: true
      t.references :topic,  index: true
      t.integer :mark,      null: false,  default: 0

      t.timestamps
    end
  end
end
