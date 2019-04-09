# frozen_string_literal: true

class SpotifyService
  def initialize(user)
    @user = user
  end

  def populate_playlist(playlist_id)
    artists = Artist.get_common_artists(@user.party)
    party_tastes = Party.get_party_tastes(@user.party)
    tracks = parse_recommendations(artists, party_tastes)
    track_uris = tracks.map {|t| t[:uri]}
    send_playlist(track_uris, playlist_id)
  end

  def current_song
    get_json('/v1/me/player/currently-playing')[:item]
  end

  def devices
    parse(request_devices)[:devices]
  end

  def request_devices
    conn.get('/v1/me/player/devices')
  end

  def parse_recommendations(artists, party_tastes)
    parse(request_recommendations(artists, party_tastes))[:tracks]
  end

  def request_recommendations(artists, target)
    conn.get('/v1/recommendations') do |req|
      req.params['seed_artists'] = artists
      req.params['target_acousticness'] = target.avg_acoust
      req.params['target_danceability'] = target.avg_dance
      req.params['target_energy'] = target.avg_energy
      req.params['target_mode'] = target.avg_mode.to_i # Request wants int
      req.params['target_valence'] = target.avg_valence
      req.params['target_tempo'] = target.avg_tempo
    end
  end

  def send_playlist(track_uris, playlist_id)
    conn.put("/v1/playlists/#{playlist_id}/tracks") do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Accept'] = 'application/json'
      faraday.body = {
        'uris' => track_uris
      }.to_json
    end
  end

  def get_tracks
    tracks = get_json('/v1/me/top/tracks?limit=100')[:items]
    ids = get_ids(tracks)
    full_info = get_music_info(ids)
    full_info.map do |track_info|
      Track.new(track_info)
    end
  end

  def make_playlist
    post_response("/v1/users/#{@user.uid}/playlists")[:id]
  end

  def get_music_info(ids)
    get_json("/v1/audio-features?ids=#{ids}")[:audio_features]
  end

  def add_artists(user)
    get_artists.each do |artist_info|
      artist_hash = make_artist_hash(artist_info, user)
      Artist.create(artist_hash)
    end
  end

  def get_artists
    get_json('/v1/me/top/artists?limit=10')[:items]
  end

  def change_playlist_name(playlist_id, name)
    conn.put("/v1/playlists/#{playlist_id}") do |req|
      req.body = {
        name: name,
        description: "Groovz generated playlist for #{Date.today}."
      }.to_json
    end
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def make_artist_hash(artist_info, user)
    {
      spotify_id: artist_info[:id],
      artist_name: artist_info[:name],
      user_id: user.id
    }
  end

  def get_ids(tracks)
    tracks.map do |track|
      track[:id]
    end.join(',')
  end

  def get_json(url)
    JSON.parse(response(url).body, symbolize_names: true)
  end

  def post_response(url)
    pr = conn.post(url) do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.body = { 'name' => "GroovzApp Playlist" }.to_json
    end
    JSON.parse(pr.body, symbolize_names: true)
  end

  def response(url)
    conn.get(url)
  end

  def conn
    refresh_token if Time.at(@user.expires_at) < Time.now
    Faraday.new(url: 'https://api.spotify.com') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{@user.token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def refresh_token
    @user.update(refresh_token: new_access_token[:refresh_token]) if new_access_token[:refresh_token]
    @user.update(token: new_access_token[:access_token], expires_at: 3600.seconds.from_now.to_i)
  end

  def new_access_token
    @info ||= JSON.parse(request_new_token.body, symbolize_names: true)
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
