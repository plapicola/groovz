class TrackService
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

  private

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
