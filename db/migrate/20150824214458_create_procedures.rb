class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.integer :experiment_id, null: false
      t.text :instructions, null: false

      t.timestamps null: false
    end
  end
end
