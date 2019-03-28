class OrderFrequency < ApplicationRecord

  belongs_to :medcation_order, optional: true, :foreign_key => 'medications'

  # The alias for enums are in place to map enums with a different name than the column name in the DB.
  alias_attribute :frequency_unit, :unit

  # Declaring enum as a Hash instead of an Array allows for easier and safer future changes.
  enum frequency_unit: { hour: 0 },
  _prefix: :frequency_unit

  validates :frequency_unit, inclusion: { in: frequency_units.keys }
end
