class License < ApplicationRecord

  validates :abbreviation, :url, :name, :terms, presence: true

  # No updates are allowed to a license once it's created
  def readonly?
    !new_record?
  end

end
