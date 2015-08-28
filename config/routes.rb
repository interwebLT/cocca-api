Rails.application.routes.draw do
  get '/site/sha', to: 'site#sha'

  resources :contacts, only: [:create]
end
