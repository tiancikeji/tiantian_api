Api::Application.routes.draw do
  resources :notifications

  resources :conversations

  resources :companies

  resources :trips

  resources :drivers

  resources :passengers

  get 'map' => 'map#index'

  namespace :api do
    get 'passengers' => 'passengers#index'
    post 'passengers/signin' => 'passengers#signin'
    post 'passengers/signup' => 'passengers#signup'
    get 'passengers/signout' => 'passengers#signout'
    post 'drivers/signup' => 'drivers#signup'
    post 'drivers/signin' => 'drivers#signin'
    post 'drivers/:id' => 'drivers#update'
    get 'drivers/signout' => 'drivers#signout'
    get 'drivers/:id' => 'drivers#show'
    get 'drivers' => 'drivers#index'
    post 'trips' => 'trips#create'
    get 'trips/:id' => 'trips#show'
    get 'conversations' => 'conversations#index'
    post 'conversations/:id' => 'conversations#update'
  end
  root :to => 'welcome#index'

end
