class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :experiment_id, null: false
      t.integer :staff_id, null: false

      t.timestamps null: false
    end
  end
end
