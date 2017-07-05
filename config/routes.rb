Rails.application.routes.draw do
  devise_for :users
  root to: 'search#index'
  resources :search
  put '/search' => 'search#update', as: :search_update
  resources :adminsettings , only:[:edit,:update]

  # Api controller
  get '/api/search/:term(/page_size/:page_size)(/page_num/:page_num)(/exact_search/:exact_search)(/order_by/:order_by)'\
      '(/order_by_direction/:order_by_direction)', to: 'api#search', :constraints => {:term => /[^\/]+/}
  get '/api/threat/:id', to: 'api#threat', :constraints => {:id => /[^\/]+/}
  get '/api/analytics/', to: 'api#analytics'
  get '/api/search_api/', to: 'search#search_api'
  post '/api/search_api/', to: 'search#search_api'
  get '/analytics', to: 'api#analytics'
  get '/reverse-admin-flag', to: 'adminsettings#reverse_admin_flag'
end
