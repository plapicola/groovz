class ArtistsSpotifyService < SpotifyService
  def add_artists(user)
    get_artists.each do |artist_info|
      artist_hash = make_artist_hash(artist_info, user)
      Artist.create(artist_hash)
    end
  end

  private

  def get_artists
    get_json('/v1/me/top/artists?limit=10')[:items]
  end

  def make_artist_hash(artist_info, user)
    {
      spotify_id: artist_info[:id],
      artist_name: artist_info[:name],
      user_id: user.id
    }
  end
end
