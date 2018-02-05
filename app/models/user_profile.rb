class UserProfile < ApplicationRecord

  belongs_to :account,
             class_name: 'OpenStax::Accounts::Account',
             inverse_of: :profile

  validates :account, presence: true

  def self.anonymous
    ::UserProfile::Anonymous.instance
  end

end
