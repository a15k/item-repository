class PowerUsersLengthValidator < ActiveModel::Validations::LengthValidator
  def validate_each(record, attribute, users)
    super(
      record,
      attribute,
      users.reject{|u| u.marked_for_destruction? || !u.power_user? }
    )
  end
end

class Member < ApplicationRecord

  has_many :assessments, inverse_of: :member, dependent: :destroy
  has_many :users, inverse_of: :member, dependent: :destroy
  has_many :access_tokens

  after_create { |member| member.access_tokens.create! }

  validate :membership_has_power_users, on: :update

  def membership_has_power_users
    unless users.find{|u| u.power_user? && !u.marked_for_destruction? }
      errors.add(:users, 'must have at least one power user')
    end
  end
end
