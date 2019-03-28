class Treatment < ApplicationRecord
  belongs_to :patient, optional: true, :foreign_key => 'treatments'
end
