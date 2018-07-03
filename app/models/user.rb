class User < ApplicationRecord

  belongs_to :account,
             class_name: 'OpenStax::Accounts::Account',
             inverse_of: :profile

  belongs_to :member, optional: true

  enum role: %i[power_user standard_user]

  def self.anonymous
    ::User::Anonymous.instance
  end

  def anonymous?
    false
  end

  def membership_access_token
     power_user? ? member.access_tokens.valid.first.token : nil
  end
end
