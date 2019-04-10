# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :party, required: false
  has_many :artists

  def update_musical_taste
    add_user_artists
    get_user_info
  end

  private

  def add_user_artists
    artists.destroy_all
    artists_service.add_artists(self)
  end

  def get_user_info
    tracks = tracks_service.get_tracks
    update(get_average_values(tracks))
  end

  def get_average_values(tracks)
    average_taste_values = {}
    user_attribute_totals(tracks).each do |attr, value|
      average_taste_values[attr] = value / 100.0
    end
    average_taste_values
  end

  def user_attribute_totals(_tracks)
    all_tracks_total = Hash.new(0)
    tracks_service.get_tracks.each do |track|
      track_attributes.each do |attr|
        all_tracks_total[attr] += track.send(attr)
      end
    end
    all_tracks_total
  end

  def track_attributes
    %i[mode acousticness danceability energy valence tempo]
  end

  def tracks_service
    @tracks_service ||= TracksSpotifyService.new(self)
  end

  def artists_service
    @artists_service ||= ArtistsSpotifyService.new(self)
  end
end
