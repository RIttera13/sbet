class DiagnosticProcedure < ApplicationRecord
  belongs_to :patient, :foreign_key => 'diagnostic_procedures'
end
