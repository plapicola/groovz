# frozen_string_literal: true

class Party < ApplicationRecord
  belongs_to :user
  has_many :users
  has_many :party_tracks, dependent: :destroy

  validates_presence_of :user_id
  validates_presence_of :code
  validates_uniqueness_of :code

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

  def new_song?
    if song_info
      return false if current_song&.spotify_id == song_info[:spotify_id]

      add_song_to_database
    end
  end

  def current_song
    party_tracks.order(:id).last
  end

  def setup_playlist
    playlist_id = playlist_service.make_playlist
    update(playlist_id: playlist_id)
  end

  def repopulate_playlist
    playlist_service.populate_playlist(playlist_id)
  end

  def update_playlist_name
    playlist_service.change_playlist_name(playlist_id, name)
  end

  private

  def self.generate_code
    RandomWord.exclude_list << /^[a-z]{6,}$/ if RandomWord.exclude_list.empty?
    RandomWord.exclude_list << /_/ if RandomWord.exclude_list.length == 1
    "#{RandomWord.adjs.first}-#{RandomWord.nouns.first}"
  end

  def song_info
    info = playlist_service.current_song
    if info
      {
        spotify_id: info[:id],
        img_url: info[:album][:images][0][:url],
        title: info[:name],
        artist: info[:artists].map { |artist| artist[:name] }.join(', ')
      }
    end
  end

  def add_song_to_database
    new_track = party_tracks.new(song_info)
    new_track.save
  end

  def playlist_service
    @playlist_service ||= PlaylistSpotifyService.new(user)
  end
end
