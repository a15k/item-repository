require 'rails_helper'

RSpec.describe Assessment, type: :model do
  it "has working factory" do
    asm = FactoryBot.create :assessment
    expect(asm.questions.count).to eq 1
  end
end
