Rails.application.routes.draw do
  get '/site/sha', to: 'site#sha'

  resources :contacts, only: [:create, :update, :show]
  resources :orders, only: [:create, :update]

  resources :hosts, only: [:create, :show], id: /.*/ do
    resources :addresses, controller: :host_addresses, only: [:create]
  end

  resources :domains, only: [:update, :show], id: /.*/ do
    resources :hosts, controller: :domain_hosts, only: [:create, :destroy]
  end

  resources :partners, only: [:create]
end
