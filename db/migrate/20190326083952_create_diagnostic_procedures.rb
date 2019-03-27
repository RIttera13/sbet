class CreateDiagnosticProcedures < ActiveRecord::Migration[5.2]
  def change
    create_table :diagnostic_procedures do |t|
      t.text :description
      t.datetime :moment
      t.integer :patient_id, index: true

      t.timestamps
    end
  end
end
