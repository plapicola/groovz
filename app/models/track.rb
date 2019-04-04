class Track
  def initialize(track_info)
    @id = track_info[:id]
    @mode = track_info[:mode]
    @acousticness = track_info[:acousticness]
    @danceability = track_info[:danceability]
    @energy = track_info[:energy]
    @valence = track_info[:valence]
    @tempo = track_info[:tempo]
  end
end
