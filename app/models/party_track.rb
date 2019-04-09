class PartyTrack < ApplicationRecord
  belongs_to :party

  validates_presence_of :title
  validates_presence_of :artist
  validates_presence_of :spotify_id
end
