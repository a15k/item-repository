require 'rails_helper'

RSpec.describe Assessment, type: :model do

  let(:assessment) { FactoryBot.create :assessment }
  let(:query) do
    <<-EOQ
      {
       assessment(id: "#{assessment.id}")
        { id
          organization{ id, name }
          license{abbreviation, name}
        }
      }
      EOQ
  end

  it 'has working factory' do
    expect(assessment).not_to be_new_record
  end

  it 'can be queried' do
    res = ItemRepositorySchema.execute(
      query,
      context: {},
      variables: {}
    )
    expect(res.to_h['data']).to(
      eq(
        'assessment' => {
          'id' => assessment.id,
          'organization' => {
            'id' => assessment.organization.id,
            'name' => assessment.organization.name
          },
          'license' => {
            'abbreviation' => assessment.license.abbreviation,
            'name' => assessment.license.name
          }
        }
      )
    )
  end
end
