class Treatment < ApplicationRecord
  belongs_to :patient, :foreign_key => 'treatments'
end
