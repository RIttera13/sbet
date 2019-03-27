class Observation < ApplicationRecord
  belongs_to :admission, :foreign_key => 'observations'
end
