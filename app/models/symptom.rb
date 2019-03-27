class Symptom < ApplicationRecord
  belongs_to :admission, :foreign_key => 'symptoms'
end
