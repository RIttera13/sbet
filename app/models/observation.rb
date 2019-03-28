class Observation < ApplicationRecord
  belongs_to :admission, optional: true, :foreign_key => 'observations'
end
