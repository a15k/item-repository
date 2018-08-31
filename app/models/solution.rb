class Solution < ApplicationRecord

  belongs_to :variant
  belongs_to :format
  belongs_to :member
  has_many :assets, as: :owner

  validates :content, :format, presence: true

end
