# frozen_string_literal: true

class User < ApplicationRecord
  def get_user_info
    tracks = track_service.get_tracks
    attr = track_attributes
    get_average_values(tracks, attr)
  end

  def track_attributes
    [:mode, :acousticness, :danceability, :energy, :valence, :tempo]
  end

  private

  def get_average_values(tracks, track_attributes)
    all_tracks_total = Hash.new(0)
    tracks.each do |track|
      track_attributes.each do |attr|
        all_tracks_total[attr] += track.send(attr)
      end
    end
    average_taste_values = {}
    all_tracks_total.each do |attr, value|
      average_taste_values[attr] = value/100
    end
    average_taste_values
  end

  def track_service
    TrackService.new(self.token)
  end

  def artist_service
    ArtistService.new
  end
end
