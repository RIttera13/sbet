class Admission < ApplicationRecord
  belongs_to :patient, :foreign_key => 'admission'
  has_one :diagnosis, dependent: :destroy
  has_one :symptom, dependent: :destroy
  has_one :observation, dependent: :destroy
end
