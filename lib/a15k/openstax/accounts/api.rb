module A15K::OpenStax::Accounts
  class Api
    def invite_user(email:)
      ::OpenStax::Accounts::FindOrCreateAccount.call(
        email: email,
        username: email,
        password: false,
      ).outputs.account
    end

  end
end
