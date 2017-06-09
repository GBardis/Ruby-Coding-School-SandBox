Rails.application.routes.draw do
  devise_for :users

  root to: 'search#index'

  resources :search do
    collection {get :search}
  end
  put '/search' => 'search#update', as: :search_update

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root 'index#search'

  # Index controller
  #  term, page_size, page_num, exact_search = true, order_by = '', order_by_direction
  # get '/search/:term', to: 'index#search'
  get '/oldindex', to: 'index#search'

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
  get '/api/search/:term(/page_size/:page_size)(/page_num/:page_num)(/exact_search/:exact_search)(/order_by/:order_by)'\
      '(/order_by_direction/:order_by_direction)', to: 'api#search', :constraints => {:term => /[^\/]+/}
  get '/api/threat/:id', to: 'api#threat', :constraints => {:term => /[^\/]+/}
  get '/api/analytics/:stats_type', to: 'api#analytics'

  get '/api/search_api/', to: 'search#search_api'
  post '/api/search_api/', to: 'search#search_api'

  # test controllers
  get 'elastic' => 'elastic#elastic'
  get 'elastic_second' => 'elastic#elastic_second'

end
