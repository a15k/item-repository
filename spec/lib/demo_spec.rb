require_relative '../rails_helper'
require_relative '../../lib/demo'

describe 'Demo data' do

  let(:member) { FactoryBot.create :member }
  let(:demo) { Demo.new(member: member) }

  it 'generates an assessment' do
    expect {
      assessment = demo.create_assessment
      p assessment.errors.full_messages

    }.to change{ Assessment.count }
  end
end
