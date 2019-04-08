# frozen_string_literal: true

class Party < ApplicationRecord
  belongs_to :user
  has_many :users

  def self.generate_party(user_id)
    user = User.find(user_id)
    Party.create(user: user, users: [user], code: generate_code)
  end

  def self.get_party_tastes(party)
    Party.select('parties.*, avg(users.acousticness) AS avg_acoust, avg(users.valence) AS avg_valence, avg(users.mode) AS avg_mode, avg(users.tempo) AS avg_tempo, avg(users.danceability) AS avg_dance, avg(users.energy) AS avg_energy')
                        .joins(:users)
                        .group(:id)
                        .where(id: party)[0]
  end

  def setup_playlist
    playlist_id = service.make_playlist
    update(playlist_id: playlist_id)
  end

  def repopulate_playlist
    service.populate_playlist(playlist_id)
  end

  def update_playlist_name
    service.change_playlist_name(playlist_id, name)
  end

  private

  def self.generate_code
    options = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    6.times.map do
      options.sample
    end.join('')
  end

  def service
    SpotifyService.new(self.user)
  end
end
