Rails.application.routes.draw do
  root 'parties#index'

  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/auth/spotify', as: :spotify_oauth
  get '/auth/spotify/callback', to: 'sessions#create', as: :spotify_callback
  get '/soundcheck', to: 'host/parties#edit', as: :soundcheck
  get '/admissions', to: 'parties#new', as: :admissions
  post '/admissions', to: 'parties#create', as: :join_party
  get '/party', to: 'parties#show', as: :party
  delete '/party', to: 'parties#delete', as: :leave_party
  get '/legal', to: 'legal#show', as: :legal
  get '/host', to: 'host/parties#show', as: :host_party
  put '/host', to: 'host/parties#update', as: :update_host_party
  delete '/host/party', to: 'host/parties#destroy', as: :cancel_party

  namespace :api do
    namespace :v1 do
      scope :me, module: :me do
        get '/available_devices', to: 'devices#index', as: :available_devices
      end
    end
  end
end
