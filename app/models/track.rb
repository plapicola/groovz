# frozen_string_literal: true

class Track
  attr_reader :mode,
              :acousticness,
              :danceability,
              :energy,
              :valence,\
              :tempo,
              :id

  def initialize(track_info)
    @id = track_info[:id]
    @mode = track_info[:mode]
    @acousticness = track_info[:acousticness]
    @danceability = track_info[:danceability]
    @energy = track_info[:energy]
    @valence = track_info[:valence]
    @tempo = track_info[:tempo]
  end

  def self.user_saved?(track_id, user)
    service = SpotifyService.new(user)
    service.user_saved?(track_id).first
  end
end
