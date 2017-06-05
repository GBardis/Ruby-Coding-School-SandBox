Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'index#search'

  # Index controller
  get '/search/:term/*other', to: 'index#search'

  # Threat controller
  get '/threat/:id', to: 'threat#show'

  get '/edit-threat/:id', to: 'threat#edit'
  put '/edit-threat/:id', to: 'threat#update'

  get '/delete-threat/:id', to: 'threat#confirmdestroy'
  delete '/delete-threat/:id', to: 'threat#destroy'

  # Analytics controller
  get '/analytics', to: 'analytics#show'

  # Admin controller
  get '/admin', to: 'admin#show'
  post '/admin', to: 'admin#edit'

  # Api controller
  get '/api/:term', to: 'api#search'

  # test controllers
  get 'elastic' => 'elastic#elastic'
  get 'elastic_second' => 'elastic#elastic_second'

  # resources :posts
end
