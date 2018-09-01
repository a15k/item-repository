require_relative '../../rails_helper'
require 'a15k/metadata'
require 'rack/test'

describe 'Metadata repo client' do
  let(:user) { FactoryBot.create(:user) }
  let(:assessment) { FactoryBot.create :assessment }
  let(:api) { A15K::Metadata.api }

  it 'can search' do
    assessment.variants.first.update_attributes! content: 'testing'
    api.create(assessment)
    expect(api.query('testing').length).to be >= 1
  end

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

  it 'can update metadata' do
    assessment.variants.first.update_attributes! content: 'pre-create'
    api.create(assessment)
    resource = api.retrieve(assessment).first
    expect(
      JSON.parse(resource.content)['variants'].first['content']
    ).to eq 'pre-create'

    assessment.variants.first.update_attributes! content: 'post-create'
    result = api.update(assessment)
    expect(result.ok?).to be true

    resource = api.retrieve(assessment).first
    expect(
      JSON.parse(resource.content)['variants'].first['content']
    ).to eq 'post-create'
  end
end
