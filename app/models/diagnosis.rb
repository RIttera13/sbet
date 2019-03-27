class Diagnosis < ApplicationRecord
  belongs_to :admission, :foreign_key => 'diagnoses'
end
