class CreateStaffsExperiments < ActiveRecord::Migration
  def change
    create_table :staffs_experiments do |t|
      t.integer :experiment_id, null: false
      t.integer :staff_id, null: false
      t.boolean :starred, null: false, default: false
      t.boolean :assigned, null: false, default: false

      t.timestamps null: false
    end
  end
end
