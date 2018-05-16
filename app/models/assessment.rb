# coding: utf-8
class Assessment < ApplicationRecord

  belongs_to :format
  belongs_to :created_by, class_name: 'User'

  enum visibility: %i[internal external]

  has_many :questions

  validates :format, :created_by, presence: true

end
