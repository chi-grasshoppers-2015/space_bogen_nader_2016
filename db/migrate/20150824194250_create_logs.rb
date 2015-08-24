class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :procedure, null: false
      t.text :observation, null: false
      t.integer :logger_id, null: false
      t.integer :experiment_id, null: false

      t.timestamps null: false
    end
  end
end
