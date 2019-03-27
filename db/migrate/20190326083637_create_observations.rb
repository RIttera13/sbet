class CreateObservations < ActiveRecord::Migration[5.2]
  def change
    create_table :observations do |t|
      t.text :description
      t.datetime :moment
      t.integer :admission_id, index: true

      t.timestamps
    end
  end
end
