class Asset < ApplicationRecord

  enum type: [
         :link,
         :image,
         :assessment
       ]

  belongs_to :assessment

  validates :assessment, :type, :content_type, presence: true

end
