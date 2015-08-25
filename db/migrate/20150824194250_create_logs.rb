class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :observation, null: false
      t.integer :staff_id, null: false
      t.integer :procedure_id, null: false
      t.decimal :time_spent, null: false
      t.datetime :time_performed, null: false

      t.timestamps null: false
    end
  end
end
