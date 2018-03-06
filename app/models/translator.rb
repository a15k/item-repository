class Translator < ApplicationRecord

  belongs_to :input, class_name: 'Format'
  belongs_to :output, class_name: 'Format'

  validates :name, presence: true

end
