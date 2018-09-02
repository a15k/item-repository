require 'rails_helper'

RSpec.describe Assessment, type: :model do
  let(:member) { FactoryBot.create :member }
  let(:assessment) { FactoryBot.create :assessment, member: member, source_identifier: '1234' }

  it 'tracks versions' do
    expect(assessment.a15k_version).to eq 1
    other = FactoryBot.create :assessment, member: member, source_identifier: '1234'
    expect(other.a15k_version).to eq 2
    versions = assessment.other_versions.reload
    expect(versions).not_to include assessment
    expect(versions).to include other
  end

  it 'has versions that only belong to the same identifier' do
    other_member = FactoryBot.create :member
    FactoryBot.create :assessment, member: other_member
    expect(assessment.other_versions).to be_empty
  end

  it 'allows a member to reuse another members source_identifier' do
    other_member = FactoryBot.create :member
    other = Assessment.new(
      source_identifier: assessment.source_identifier,
      member: other_member
    )
    expect(other.save).to be true
  end

  it 'disallows other members from making new versions using a15k_identifier' do
    other_member = FactoryBot.create :member
    other = Assessment.new(
      a15k_identifier: assessment.a15k_identifier,
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

  it 'requires source_identifier if source_version set' do
    assessment = FactoryBot.build :assessment, source_version: "blah", source_identifier: nil
    expect(assessment).not_to be_valid
    expect(assessment.errors[:source_identifier]).to include("can't be blank")
  end

  it 'requires source version and identifier to be unique in a member' do
    assessment = FactoryBot.create :assessment, source_version: "1", source_identifier: "1"
    other_assessment = FactoryBot.build :assessment, source_version: "1", source_identifier: "1", member: assessment.member
    expect(other_assessment).not_to be_valid
    expect(other_assessment.errors[:source_version]).to include(/taken/)
  end

  it 'allows source version and identifier to be repeated across members' do
    assessment = FactoryBot.create :assessment, source_version: "1", source_identifier: "1"
    other_assessment = FactoryBot.build :assessment, source_version: "1", source_identifier: "1"
    expect(other_assessment).to be_valid
  end

  it 'requires a prior version if a15k_identifier set before create' do
    assessment = Assessment.create(a15k_identifier: "howdy")
    expect(assessment).not_to be_valid
    expect(assessment.errors[:a15k_identifier]).to include(/can only be given when a prior version/)
  end

end
