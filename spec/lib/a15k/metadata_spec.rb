require_relative '../../rails_helper'
require 'a15k/metadata'
require 'rack/test'

describe 'Metadata repo client' do

  let(:user) { FactoryBot.create(:user) }
  let(:assessment) { FactoryBot.create :assessment }
  let(:api) { A15K::Metadata::FakeApi.new(user: user) }

  it 'can make call' do
    model = api.add_assessment(assessment)
    expect(model.ok?).to be true
  end

end
