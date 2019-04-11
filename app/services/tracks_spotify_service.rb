# frozen_string_literal: true

class TracksSpotifyService < SpotifyService
  def get_tracks
    tracks = get_json('/v1/me/top/tracks?limit=50')[:items]
    ids = get_ids(tracks)
    full_info = get_music_info(ids)
    full_info.map do |track_info|
      Track.new(track_info)
    end
  end

  def user_saved?(track_id)
    parse(user_saved_request(track_id))
  end

  def save_track(track_id)
    conn.put('/v1/me/tracks') do |req|
      req.params[:ids] = track_id
    end
    'Song Saved'
  end

  def remove_track(track_id)
    conn.delete('/v1/me/tracks') do |req|
      req.params[:ids] = track_id
    end
    'Song Removed'
  end

  def skip_current_track
    conn.post('/v1/me/player/next')
  end

  private

  def user_saved_request(track_id)
    conn.get('/v1/me/tracks/contains') do |req|
      req.params[:ids] = track_id
    end
  end

  def get_music_info(ids)
    get_json("/v1/audio-features?ids=#{ids}")[:audio_features]
  end

  def get_ids(tracks)
    tracks.map do |track|
      track[:id]
    end.join(',')
  end
end
