Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount OpenStax::Accounts::Engine, at: 'accounts'

  namespace :api do
    api_version(
      module: 'V1',
      default: true,
      path: { value: 'v1' },
      header: {
        name: 'Accept',
        value: 'application/vnd.interactions.a15k.org; version=1'
      }
    ) do

      resources :formats, only: [:index, :create]
      resources :assessments
      resources :interactions
    end
  end

  get 'api/docs/v1', to: 'api/docs/v1#index'

  get '*path', to: 'home#index'
  root to: 'home#index'

end
