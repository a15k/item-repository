require_relative '../demo/member_a'

desc <<-DESC.strip_heredoc
  Generate demo2 data
DESC
task :demo2, [] => :environment do |tt,args|

  demo_member_a = Demo2::MemberA.new(member_name: "OpenStax")

  [
    %w[ox standard_user],
    %w[ox_power_user power_user]
  ].each do |username, role|
    account = ::OpenStax::Accounts::FindOrCreateAccount.call(
      email: 'support@openstax.org', username: username, password: 'password'
    ).outputs.account
    User.create!(
      member_id: demo_member_a.member.id, account_id: account.id, role: role
    )
  end

  7.times { demo_member_a.generate_multiple_choice }
  4.times { demo_member_a.generate_fill_in_the_blank }
  8.times { demo_member_a.generate_short_answer }

end
