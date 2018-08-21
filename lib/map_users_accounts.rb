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
      User.anonymous if account.is_anonymous?
    end

    def find_or_create_user(account)
      retry_count = 0
      begin
        user = User.where(account: account).first
        return user if user.present?
        User.create!(account: account)
      rescue RuntimeError, ActiveRecord::RecordNotUnique, ::PG::UniqueViolation
        raise if retry_count >= 3

        retry_count += 1
        retry
      end
    end
  end

end
