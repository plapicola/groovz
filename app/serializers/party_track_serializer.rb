class PartyTrackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :spotify_id, :img_url, :title, :artist
end
