class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :observation, null: false
      t.integer :logger_id, null: false
      t.integer :procedure_id, null: false

      t.timestamps null: false
    end
  end
end
