class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :variant
      t.references :user
      t.integer :assessment,  null: false

      t.timestamps
    end
  end
end
