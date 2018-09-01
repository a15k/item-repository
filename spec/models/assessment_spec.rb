require 'rails_helper'

RSpec.describe Assessment, type: :model do
  let(:member) { FactoryBot.create :member }
  let(:assessment) { FactoryBot.create :assessment, member: member, identifier: '1234' }

  it 'tracks versions' do
    expect(assessment.version).to eq 1
    other = FactoryBot.create :assessment, member: member, identifier: '1234'
    expect(other.version).to eq 2
    versions = assessment.other_versions.reload
    expect(versions).not_to include assessment
    expect(versions).to include other
  end

  it 'has versions that only belong to the same identifier' do
    other_member = FactoryBot.create :member
    FactoryBot.create :assessment, member: other_member
    expect(assessment.other_versions).to be_empty
  end

  it 'disallows other members from making new versions' do
    other_member = FactoryBot.create :member
    other = Assessment.new(
      identifier: assessment.identifier,
      member: other_member
    )
    expect(other.other_versions.size).to eq 1
    expect(other.save).to be false
    expect(other.errors[:member]).to include 'must be the same as other versions'
  end

  it 'blocks duplicate assessment content' do
    dupe = FactoryBot.build :assessment
    assessment.variants.each{ |q| dupe.variants.build(content: q.content, format: q.format) }
    expect(dupe.save).to be false
    expect(dupe.errors.full_messages).to include 'Fingerprint has already been taken'
  end

end
