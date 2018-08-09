class User < ApplicationRecord

  belongs_to :account,
             class_name: 'OpenStax::Accounts::Account',
             inverse_of: :profile

  belongs_to :member, optional: true

  enum role: %i[standard_user power_user]

  scope :power_users, -> { where(role: 'power_user') }

  validate :membership_has_power_users, on: :update

  def self.anonymous
    ::User::Anonymous.instance
  end

  def anonymous?
    false
  end

  def power_user?
    self.role == 'power_user' && member.present?
  end

  def member_info
    return {} unless member.present?
    info = {
      member_name: member.name,
      member_power_users: member.users.power_users.map{|u| { name: u.account.name } },
    }
    if power_user?
      info[:token] = member.access_tokens.first.token
    end
    info
  end

  protected

  def membership_has_power_users
    if !power_user? && role_changed? && member.users.power_users.count < 2
      errors.add(:member, 'must have at least one power user')
    end
  end
end
