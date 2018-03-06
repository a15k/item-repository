class User < ApplicationRecord

  belongs_to :account,
             class_name: 'OpenStax::Accounts::Account',
             inverse_of: :profile

  belongs_to :organization

  def self.anonymous
    ::User::Anonymous.instance
  end

end
