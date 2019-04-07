Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'],
  scope: %w[user-modify-playback-state
          playlist-modify-public
          user-top-read
          user-read-currently-playing
          user-library-modify].join(' ')
end
