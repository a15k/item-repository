class Format < ApplicationRecord

  validates :name, :description, presence: true

end
