require 'rails_helper'

RSpec.describe AssessmentController, type: :controller do
    render_views

    let(:assessment) { FactoryBot.create :assessment }

    describe "GET preview" do
      it "renders the assessment preview html" do
        get :preview, params: { id: assessment.id }
        expect(response.body).to include assessment.variants[0].preview_html
      end
    end
end
