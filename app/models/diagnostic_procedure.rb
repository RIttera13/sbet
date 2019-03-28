class DiagnosticProcedure < ApplicationRecord
  belongs_to :patient, optional: true, :foreign_key => 'diagnostic_procedures'
end
