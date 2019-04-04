# frozen_string_literal: true

class User < ApplicationRecord
  def get_user_info
    track_service.get_tracks
  end

  private

  def track_service
    TrackService.new(self.token)
  end

  def artist_service
    ArtistService.new
  end
end
