# coding: utf-8
class Assessment < ApplicationRecord

  belongs_to :format
  belongs_to :created_by, class_name: 'Member'

  enum visibility: %i[internal external]

  has_many :questions, inverse_of: :assessment
  validates :format, :created_by, presence: true

  validates :version, uniqueness: { scope: :identifier }

end
