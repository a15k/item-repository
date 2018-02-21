class Asset < ApplicationRecord

  enum type: [
         :link,
         :image,
         :assessment,
         :solution,
         :solution_key
       ]

  belongs_to :assessment
  belongs_to :related_asset, class_name: 'Asset', optional: true

  validates :type, :content_type, presence: true

end
