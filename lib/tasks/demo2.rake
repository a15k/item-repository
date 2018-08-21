require_relative '../demo/member_a'
require_relative '../demo/member_b'

desc <<-DESC.strip_heredoc
  Generate demo2 data
DESC
task :demo2, [] => :environment do |tt,args|

  demo_member_a = Demo2::MemberA.new(member_name: "Assessify")
  create_user(username: "as", member: demo_member_a.member, power_user: false)
  create_user(username: "as_power_user", member: demo_member_a.member, power_user: true)

  7.times { demo_member_a.generate_multiple_choice }
  4.times { demo_member_a.generate_fill_in_the_blank }
  8.times { demo_member_a.generate_short_answer }

  demo_member_b = Demo2::MemberB.new(member_name: "Thinker Publishing")
  create_user(username: "tp", member: demo_member_b.member, power_user: false)
  create_user(username: "tp_power_user", member: demo_member_b.member, power_user: true)

  6.times { demo_member_b.generate_multiple_choice }
  8.times { demo_member_b.generate_fill_in_the_blank }
  2.times { demo_member_b.generate_short_answer }

end

def create_user(username:, member:, power_user:)
  account = ::OpenStax::Accounts::FindOrCreateAccount.call(
    email: "demo+#{SecureRandom.hex(6)}@a15k.org", username: username, password: 'password'
  ).outputs.account
  User.create!(
    member_id: member.id, account_id: account.id, role: power_user ? 'power_user' : 'standard_user'
  )
end
