class Allergy < ApplicationRecord
  belongs_to :patient, :foreign_key => 'allergies'
end
