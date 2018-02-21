require 'rails_helper'

RSpec.describe AssessmentOwner, type: :model do
  it "has working factory" do
    FactoryBot.create :assessment_owner
  end
end
