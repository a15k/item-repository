class Version < ApplicationRecord
  belongs_to :assessment
  belongs_to :format
  belongs_to :created_by, class_name: 'UserProfile'

  has_many :assets, inverse_of: :version
  has_many :version_tags
  has_many :tags, through: :version_tags

  enum visiblity: %i[internal external]

  validates :format, :created_by, :assessment, presence: true
end
