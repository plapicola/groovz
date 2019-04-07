# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :party, required: false
  has_many :artists

  def update_musical_taste
    add_user_artists
    get_user_info
  end

  private

  def track_attributes
    %i[mode acousticness danceability energy valence tempo]
  end

  def get_user_info
    tracks = service.get_tracks
    update(get_average_values(tracks))
  end

  def add_user_artists
    artists.destroy_all
    service.add_artists(self)
  end

  def get_average_values(tracks)
    average_taste_values = {}
    user_attribute_totals(tracks).each do |attr, value|
      average_taste_values[attr] = value / 100.0
    end
    average_taste_values
  end

  def user_attribute_totals(tracks)
    all_tracks_total = Hash.new(0)
    tracks.each do |track|
      track_attributes.each do |attr|
        all_tracks_total[attr] += track.send(attr)
      end
    end
    all_tracks_total
  end

  def service
    @service ||= SpotifyService.new(self)
  end
end
