require_relative '../../rails_helper'
require 'a15k/metadata'
require 'rack/test'

describe 'Metadata repo client' do

  let(:user) { FactoryBot.create(:user) }
  let(:assessment) { FactoryBot.create :assessment }
  let(:api) { A15K::Metadata.api(user: user) }

  it 'can create a resource for assessments' do
    result = api.create(assessment)
    expect(result.ok?).to be true
  end

  it 'can retrieve metadata' do
    api.create(assessment)
    found = api.retrieve(assessment)
    expect(found.length).to eq 1
    expect(
      JSON.parse(found[0].content)
    ).to eq ::Api::V1::AssessmentSerializer.new(assessment).as_json
  end

end
