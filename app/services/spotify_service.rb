# frozen_string_literal: true

class SpotifyService
  def initialize(token)
    @token = token
  end

  def get_tracks
    tracks = get_json('/v1/me/top/tracks?limit=100')[:items]
    ids = get_ids(tracks)
    full_info = get_music_info(ids)
    full_info.map do |track_info|
      Track.new(track_info)
    end
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

  def response(url)
    conn.get(url)
  end

  def conn
    Faraday.new(url: 'https://api.spotify.com') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{@token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
