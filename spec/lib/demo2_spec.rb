require_relative '../rails_helper'
require_relative '../../lib/demo/member_a'

describe 'Demo data' do

  let(:demo_member) { Demo2::MemberA.new(member_name: "OpenStax") }

  it 'generates a short answer assessment' do
    expect{
      demo_member.generate_short_answer
    }.to change{ Assessment.count }
  end

  it 'generates a multiple choice assessment' do
    expect{
      demo_member.generate_multiple_choice
    }.to change{ Assessment.count }
  end

  it 'generates a fill in the blank assessment' do
    expect{
      demo_member.generate_fill_in_the_blank
    }.to change{ Assessment.count }
  end
end
