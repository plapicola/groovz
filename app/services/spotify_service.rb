# frozen_string_literal: true

class SpotifyService
  def initialize(user)
    @user = user
  end

  def populate_playlist(playlist_id)
    artists = Artist.select("spotify_id")
                    .joins(user: :party)
                    .where(parties: {playlist_id: playlist_id})
                    .group(:id)
                    .limit(5)
                    .pluck(:spotify_id)
                    .join(',')

                    # ADD BACK IN FREQUENCY ALIAS AND ORDER
    party_tastes = User.select("users.*, avg(users.acousticness) AS avg_acoust, avg(users.valence) AS avg_valence, avg(users.mode) AS avg_mode, avg(users.tempo) AS avg_tempo, avg(users.danceability) AS avg_dance, avg(users.energy) AS avg_energy")
                        .joins(:party)
                        .group(party: :id)
                        .where(party: {playlist_id: playlist_id})
    binding.pry
    mode = @user.mode.to_i
    track_info = get_json("/v1/recommendations?seed_artists=#{artists}&target_acousticness=#{@user.acousticness}&target_danceability=#{@user.danceability}&target_energy=#{@user.energy}&target_mode=#{mode}&target_valence=#{@user.valence}&target_tempo=#{@user.tempo}")[:tracks]
    track_uris = track_info.map do |track|
      track[:uri]
    end

    Faraday.put("https://api.spotify.com/v1/playlists/#{playlist_id}/tracks") do |faraday|
      faraday.headers['Authorization'] = "Bearer #{@user.token}"
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

  private

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
      faraday.body = {'name' => "#{@user.name}'s party playlist"}.to_json
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
    @user.update(token: new_access_token, expires_at: 3600.seconds.from_now.to_i)
  end

  def new_access_token
    JSON.parse(request_new_token.body)['access_token']
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
