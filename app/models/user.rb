class User < ApplicationRecord

  belongs_to :account,
             class_name: 'OpenStax::Accounts::Account',
             inverse_of: :profile

  belongs_to :member

  def self.anonymous
    ::User::Anonymous.instance
  end

  def anonymous?
    false
  end

  enum role: %i[power_user standard_user]

end
