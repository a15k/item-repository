class User < ApplicationRecord

  belongs_to :account,
             class_name: 'OpenStax::Accounts::Account',
             inverse_of: :profile

  belongs_to :member, optional: true

  enum role: %i[power_user standard_user]

  scope :power_users, -> { where(role: 'power_user') }

  validate :membership_has_power_users

  def self.anonymous
    ::User::Anonymous.instance
  end

  def anonymous?
    false
  end

  def power_user?
    self.role == 'power_user' && member.present?
  end

  def membership_access_token
     power_user? ? member.access_tokens.valid.first.token : nil
  end

  protected

  def membership_has_power_users
    if (member_id.nil? && member_id_changed?) || # unlinking
       (role_changed? && !power_user?) # downgrading from power user

      if Member.find(member_id || member_id_was).users.power_users.count < 2
        errors.add(:member, 'must have at least one power user')
      end

    end
  end
end
