Rails.application.routes.draw do
  namespace :host do
    get 'parties/new'
  end
  root 'parties#index'

  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/auth/spotify', as: :spotify_oauth
  get '/auth/spotify/callback', to: 'sessions#create', as: :spotify_callback
  get '/soundcheck', to: 'host/parties#new', as: :soundcheck
  get '/admissions', to: 'parties#new', as: :admissions
end
