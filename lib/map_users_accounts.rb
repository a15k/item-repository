module MapUsersAccounts

  class << self
    def account_to_user(account)
      anonymous_user(account) || find_or_create_user(account)
    end

    def user_to_account(user)
      user.account
    end

    private

    def anonymous_user(account)
      UserProfile.anonymous if account.is_anonymous?
    end

    def find_or_create_user(account)
      retry_count = 0
      begin
        user = UserProfile.where(account: account).first
        return user if user.present?
        # TODO: somehow get organization from somewhere
        UserProfile.create!(
          account: account,
          organization: Organization.find_or_create_by(name: 'OpenStax')
        )
      rescue RuntimeError, ActiveRecord::RecordNotUnique, ::PG::UniqueViolation
        raise if retry_count >= 3

        retry_count += 1
        retry
      end
    end
  end

end
