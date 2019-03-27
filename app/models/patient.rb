class Patient < ApplicationRecord

  include PgSearch

  has_one :admission, dependent: :destroy
  has_one :allergy, dependent: :destroy
  has_one :diagnosis, through: :admission
  has_one :medication_order, dependent: :destroy
  has_one :diagnostic_procedure, dependent: :destroy
  has_one :treatment, dependent: :destroy

  # Declaring enum as a Hash instead of an Array allows for easier and safer future changes.
  enum gender: { male: 0, female: 1, other: 2 },
  _prefix: :gender

  validates :gender, inclusion: { in: genders.keys }


  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |patient|
        csv << patient.attributes.values_at(*column_names)
      end
    end
  end

  filterrific(
    default_filter_params: { with_date_of_gte: 1.month.ago, sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_by,
      :with_date_of_gte,
      :with_date_of_lt
    ]
  )

 # always include the lower boundary for semi open intervals
 scope :with_date_of_gte, lambda { |reference_time|
   where('patients.created_at >= ?', reference_time)
 }

 # always exclude the upper boundary for semi open intervals
 scope :with_date_of_lt, lambda { |reference_time|
   where('patients.created_at <= ?', reference_time)
 }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      # Simple sort on the created_at column.
      # Make sure to include the table name to avoid ambiguous column names.
      # Joining on other tables is quite common in Filterrific, and almost
      # every ActiveRecord table has a 'created_at' column.
      order("patients.created_at #{ direction }")
    when /^last_name_/
      # Simple sort on the name colums
      order("patients.last_name #{ direction }")
    when /^first_name_/
      # Simple sort on the name colums
      order("patients.first_name #{ direction }")
    when /^mr_/
      # Simple sort on the name colums
      order("patients.mr #{ direction }")
    when /^dob_/
      # Simple sort on the name colums
      order("patients.dob #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  pg_search_scope :search_by, :against => [:first_name, :last_name, :middle_name, :mr, :dob]

end
