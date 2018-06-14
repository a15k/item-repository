class Solution < ApplicationRecord

  belongs_to :question
  belongs_to :format
  belongs_to :created_by, class_name: 'Member'
  has_many :assets, as: :owner

  validates :content, :format, presence: true

end
