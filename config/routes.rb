Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount OpenStax::Accounts::Engine, at: 'accounts'

  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :formats, only: [:index]
    end
  end
end
