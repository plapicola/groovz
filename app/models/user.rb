# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :party, required: false
  has_many :artists

  def get_user_info
    tracks = service.get_tracks
    get_average_values(tracks)
  end

  def add_user_artists
    service.add_artists(self)
  end

  private

  def track_attributes
    [:mode, :acousticness, :danceability, :energy, :valence, :tempo]
  end

  def get_average_values(tracks)
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

  def service
    @service ||= SpotifyService.new(self.token)
  end
end
