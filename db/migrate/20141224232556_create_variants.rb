class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.references :test
      t.integer    :number,   null: false

      t.timestamps
    end

    add_index :variants, [:test_id, :number]
  end
end
