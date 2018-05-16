class Question < ApplicationRecord

  belongs_to :assessment
  belongs_to :format
  belongs_to :created_by, class_name: 'User'
  has_many :solutions, inverse_of: :question, dependent: :destroy
  has_many :assets, as: :owner, dependent: :destroy

  validates :content, :created_by, :format, presence: true

end
