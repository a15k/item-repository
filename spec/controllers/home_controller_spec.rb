require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  it 'renders login link for anonymous user' do
    get :index
    expect(response.body).to include 'Login'
  end


  it 'renders app view when logged in' do
    user = FactoryBot.create(:user)

    allow_any_instance_of(HomeController)
      .to(receive(:current_user))
      .and_return(user)

    get :index

    expect(response.body).to include 'bootstrap-data'
  end
end
