class User < ApplicationRecord

  belongs_to :account,
             class_name: 'OpenStax::Accounts::Account',
             inverse_of: :profile

  belongs_to :organization

  validates :account, presence: true

  def self.anonymous
    ::User::Anonymous.instance
  end

end
