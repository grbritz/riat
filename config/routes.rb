Riat::Application.routes.draw do

  # TODO: not sure if needed yet
  # From Composite-Primary-Keys wiki
  #map.connect ‘:controller/:action/:id’, :id => /\w+(,\w+)*/
  #
  get ':controller(/:action(/:id))'
  root to: 'main#index'
  get 'distant_supervision1/task' => 'distant_supervision1#task'
  post 'distant_supervision1/update' => 'distant_supervision1#update'
  
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/signup', to: 'users#new', via: 'get'

end
