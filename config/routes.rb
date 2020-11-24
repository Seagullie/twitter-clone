Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'} # what's that hash, i wonder
  resources :tweeets
  root 'tweeets#index'
  get '/:handle', to: 'users#profile', as: 'user_handle'
  get '/users/:handle/followList', to: 'users#follow_list'
  get '/users/:handle/followers', to: 'users#followers'
  post '/users/:handle/follow', to: 'users#follow'
  post '/users/:handle/unfollow', to: 'users#unfollow'
  get '/users/search', to: 'users#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
