class Diagnosis < ApplicationRecord
  belongs_to :admission, optional: true, :foreign_key => 'diagnoses'
end
