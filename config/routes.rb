Rails.application.routes.draw do
  root 'parties#index'

  get '/login', to: 'sessions#new', as: :login
end
