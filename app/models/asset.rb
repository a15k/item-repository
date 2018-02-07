class Asset < ApplicationRecord

  enum type: [
         :link,
         :image,
         :assessment
       ]

  belongs_to :version

  validates :version, :type, :content_type, presence: true

end
