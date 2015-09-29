Rails.application.routes.draw do
  get '/site/sha', to: 'site#sha'

  resources :contacts, only: [:create, :update]
  resources :orders, only: [:create, :update]
  resources :hosts, only: [:create] do 
    resources :addresses, only: [:create]
  end
end
