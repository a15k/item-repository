module SigninHelpers
  def stub_current_user(user, recipient=ApplicationController)

    allow_any_instance_of(recipient)
      .to receive(:current_user)
      .and_return(user) if recipient.method_defined?(:current_user)

  end

  def unstub_current_user(recipient=ApplicationController)
    allow_any_instance_of(recipient)
      .to receive(:current_user)
      .and_call_original if recipient.method_defined?(:current_user)
  end
end
