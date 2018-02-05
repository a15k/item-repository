Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    mount OpenStax::Accounts::Engine, at: 'accounts'

    root to: 'home#index'
end
