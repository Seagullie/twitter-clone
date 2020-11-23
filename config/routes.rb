Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'} # what's that hash, i wonder
  resources :tweeets
  root 'tweeets#index'
  get '/:handle', to: 'users#profile', as: 'user_handle'
  post '/users/:handle/follow', to: 'users#follow'
  post '/users/:handle/unfollow', to: 'users#unfollow'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
