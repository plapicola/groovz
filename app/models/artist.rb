# frozen_string_literal: true

class Artist < ApplicationRecord
  belongs_to :user

  validates_presence_of :spotify_id
  validates_presence_of :user_id

  def self.get_common_artists(party)
    Artist.select('artists.spotify_id, COUNT(artists.user_id) AS frequency')
                    .joins(user: :party)
                    .where(parties: { id: party })
                    .group(:spotify_id)
                    .order('frequency desc')
                    .limit(5)
                    .map(&:spotify_id)
                    .join(',')
  end
end
