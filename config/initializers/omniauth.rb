Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'],
  scope: %w[user-read-playback-state
            user-top-read
            playlist-modify-public
            user-modify-playback-state].join(" ")
end
