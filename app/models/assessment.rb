class Assessment < ApplicationRecord

  belongs_to :format
  belongs_to :created_by, class_name: 'User'

  enum visibility: %i[internal external]

  has_many :questions
  has_many :solutions

  # has_many :related, -> { where(identifier: identifier) } )class_name: 'Assessment',

end
