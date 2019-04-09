class TracksSpotifyService < SpotifyService
  def get_tracks
    tracks = get_json('/v1/me/top/tracks?limit=100')[:items]
    ids = get_ids(tracks)
    full_info = get_music_info(ids)
    full_info.map do |track_info|
      Track.new(track_info)
    end
  end

  private
  
  def get_music_info(ids)
    get_json("/v1/audio-features?ids=#{ids}")[:audio_features]
  end

  def get_ids(tracks)
    tracks.map do |track|
      track[:id]
    end.join(',')
  end
end
