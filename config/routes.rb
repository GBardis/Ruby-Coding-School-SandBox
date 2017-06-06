Rails.application.routes.draw do
  # root to: 'search#search'
  #get '/search' => 'search#search', as: :search
  root to: 'search#index'

  resources :search do
    collection { get :search }
  end
  put '/search' => 'search#update', as: :search_update
end
