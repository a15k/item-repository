class Assessment < ApplicationRecord

  belongs_to :owner, class_name: 'AssessmentOwner'
  belongs_to :format
  belongs_to :created_by, class_name: 'User'

  has_many :assets, inverse_of: :version
  has_many :version_tags
  has_many :tags, through: :version_tags

  enum visiblity: %i[internal external]

end
