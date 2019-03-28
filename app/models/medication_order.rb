class MedicationOrder < ApplicationRecord

  belongs_to :patient, optional: true, :foreign_key => 'medications'
  has_one :order_frequency, dependent: :destroy
  accepts_nested_attributes_for :order_frequency, allow_destroy: true

  # The alias for enums are in place to map enums with a different name than the column name in the DB.
  alias_attribute :mass_unit, :unit
  # Declaring enum as a Hash instead of an Array allows for easier and safer future changes.
  enum mass_unit: { mg: 0 },
  _prefix: :mass_unit

  alias_attribute :medication_route, :route
  enum medication_route: { po: 0, im: 1, sc: 2 },
  _prefix: :medication_route

  validates :mass_unit, inclusion: { in: mass_units.keys }
  validates :medication_route, inclusion: { in: medication_routes.keys }
end
