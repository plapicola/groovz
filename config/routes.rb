Rails.application.routes.draw do
  root 'parties#index'

  get '/login', to: 'sessions#new', as: :login
  get '/auth/spotify', as: :spotify_oath
  get '/auth/spotify/callback', to: 'sessions#create', as: :spotify_callback
end
