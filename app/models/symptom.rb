class Symptom < ApplicationRecord
  belongs_to :admission, optional: true, :foreign_key => 'symptoms'
end
