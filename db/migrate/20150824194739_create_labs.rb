class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :location, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
