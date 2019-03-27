class CreateOrderFrequencies < ActiveRecord::Migration[5.2]
  def change
    create_table :order_frequencies do |t|
      t.string :value
      t.integer :unit
      t.integer :medication_order_id, index: true

      t.timestamps
    end
  end
end
