class CreateDiagnosis < ActiveRecord::Migration[5.2]
  def change
    create_table :diagnosis do |t|
      # I kept the misspelt coding_systen in case it was intentional
      t.string :coding_systen
      t.string :code
      t.text :description
      t.integer :admission_id, index: true

      t.timestamps
    end
  end
end
