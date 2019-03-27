class CreateTreatments < ActiveRecord::Migration[5.2]
  def change
    create_table :treatments do |t|
      t.text :description
      t.text :necessity
      t.integer :patient_id, index: true

      t.timestamps
    end
  end
end
