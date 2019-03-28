class Allergy < ApplicationRecord
  belongs_to :patient, optional: true, :foreign_key => 'allergies'
end
