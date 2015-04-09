class CreateTopicsCompetences < ActiveRecord::Migration
  def change
    create_table :topics_competences, id: false do |t|
      t.references :topic, index: true
      t.references :competence, index: true
	    t.integer :weight
	  
      t.timestamps
    end
  end
end
