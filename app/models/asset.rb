class Asset < ApplicationRecord

  belongs_to :owner, polymorphic: true
  belongs_to :created_by, class_name: 'Member'

  validates :content_type, presence: true

end
