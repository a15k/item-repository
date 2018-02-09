Rails.application.routes.draw do

  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount OpenStax::Accounts::Engine, at: 'accounts'


  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  root to: 'home#index'

end
