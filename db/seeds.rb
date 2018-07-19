# members/accounts will be configured by deployment scripts on production
# and in test mode by the factories
if Rails.env.development?

  OX = 'OpenStax'.freeze

  unless Member.exists?(name: OX)
    Member.create!(name: OX, website: 'openstax.org')
  end

  OX_MEMBER = Member.find_by(name: OX)
  unless User.exists?(member_id: OX_MEMBER.id)
    [
      %w[ox standard_user],
      %w[ox_power_user power_user]
    ].each do |username, role|

      account = ::OpenStax::Accounts::FindOrCreateAccount.call(
        email: 'support@openstax.org', username: username, password: 'password'
      ).outputs.account
      User.create!(
        member_id: OX_MEMBER.id, account_id: account.id, role: role
      )
    end
  end

  unless Format.exists?(name: OX)
    Format.create!(
      name: OX,
      identifier: 'openstax',
      specification: 'Openstax exercise format, see https://openstax.org/ for details',
      created_by: OX_MEMBER
    )
  end
end
