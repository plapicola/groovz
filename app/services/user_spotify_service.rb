# frozen_string_literal: true

class UserSpotifyService < SpotifyService
  def refresh_token
    @user.update(refresh_token: new_access_token[:refresh_token]) if new_access_token[:refresh_token]
    @user.update(token: new_access_token[:access_token], expires_at: 3600.seconds.from_now.to_i)
  end

  def devices
    parse(request_devices)[:devices]
  end

  private

  def request_devices
    conn.get('/v1/me/player/devices')
  end

  def new_access_token
    @new_access_token ||= JSON.parse(request_new_token.body, symbolize_names: true)
  end

  def request_new_token
    Faraday.post('https://accounts.spotify.com/api/token') do |faraday|
      faraday.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      faraday.body = query_hash.to_query
    end
  end

  def query_hash
    {
      'grant_type' => 'refresh_token',
      'refresh_token' => @user.refresh_token,
      'redirect_uri' => 'groovzapp.com/auth/spotify/callback',
      'client_id' => ENV['SPOTIFY_CLIENT_ID'],
      'client_secret' => ENV['SPOTIFY_CLIENT_SECRET']
    }
  end
end
