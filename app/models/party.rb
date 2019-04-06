# frozen_string_literal: true

class Party < ApplicationRecord
  belongs_to :user
  has_many :users

  def self.generate_party(user)
    playlist_id = service(user).make_playlist
    service(user).populate_playlist(playlist_id)
    create(user: user, users: [user], code: generate_code, playlist_id: playlist_id)
  end

  private

  def self.generate_code
    options = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    6.times.map do
      options.sample
    end.join('')
  end

  def self.service(user)
    SpotifyService.new(user)
  end
end
