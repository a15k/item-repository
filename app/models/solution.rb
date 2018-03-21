class Solution < ApplicationRecord

  belongs_to :assessment
  belongs_to :format
  belongs_to :created_by, class_name: 'User'
  has_many :assets, inverse_of: :version

  # TODO add a validate method to format and use it to verify content is well-formed
  validates :content, presence: true
end
