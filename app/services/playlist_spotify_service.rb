# frozen_string_literal: true

class PlaylistSpotifyService < SpotifyService
  def send_play
    conn.put('v1/me/player/play')
  end

  def send_pause
    conn.put('v1/me/player/pause')
  end

  def current_song
    @song ||= get_json('/v1/me/player/currently-playing')
    toggle_play_or_pause
    @song[:item] if @song
  end

  def populate_playlist(playlist_id)
    artists = Artist.get_common_artists(@user.party)
    party_tastes = Party.get_party_tastes(@user.party)
    tracks = parse_recommendations(artists, party_tastes)
    track_uris = tracks.map { |t| t[:uri] }
    send_playlist(track_uris, playlist_id)
  end

  def change_playlist_name(playlist_id, name)
    conn.put("/v1/playlists/#{playlist_id}") do |req|
      req.body = {
        name: name,
        description: "Groovz generated playlist for #{Date.today}."
      }.to_json
    end
  end

  def make_playlist
    post_response("/v1/users/#{@user.uid}/playlists")[:id]
  end

  def start_playback
    request_playback_start
  end

  private

  def toggle_play_or_pause
    if @song && @song[:is_playing] != @user.party.playing
      @user.party.update(playing: @song[:is_playing])
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

  def request_playback_start
    conn.put('/v1/me/player/play') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params[:device_id] = @user.party.device_id
      req.body = {
        context_uri: "spotify:playlist:#{@user.party.playlist_id}"
      }.to_json
    end
  end
end
