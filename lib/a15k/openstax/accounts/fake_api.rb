module A15K::OpenStax::Accounts

  class FakeApi

    def invite_user(email:)
      ::OpenStax::Accounts::Account.where(username: email).first ||
        ::OpenStax::Accounts::Dev::CreateAccount.call(
          username: email, email: email
        ).outputs.account
    end

  end
end
