class Assessment < ApplicationRecord

  belongs_to :format
  belongs_to :created_by, class_name: 'User'

  enum visiblity: %i[internal external]

  # has_many :related, -> { where(identifier: identifier) } )class_name: 'Assessment',

end
