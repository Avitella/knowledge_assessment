class CreateAnswerLogs < ActiveRecord::Migration
  def change
    create_table :answer_logs do |t|
      t.references :result
      t.references :answer

      t.timestamps
    end
  end
end
