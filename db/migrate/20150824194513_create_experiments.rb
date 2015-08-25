class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :title, null: false
      t.string :hypothesis, null: false
      t.text :description, null: false
      t.string :conclusion
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :owner_id, null: false
      t.integer :lab_id, null: false

      t.timestamps null: false
    end
  end
end
