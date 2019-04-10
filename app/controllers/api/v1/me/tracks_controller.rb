# frozen_string_literal: true

module Api
  module V1
    module Me
      class TracksController < ApplicationController
        skip_forgery_protection

        def show
          render json: PartyTrackSerializer.new(current_user.party&.current_song)
        end

        def update
          if user_owns_party?
            PlaylistSpotifyService.new(current_user).start_playback
            QueryCurrentPlayingJob.perform_later(current_user.party.id)
            head :ok
          else
            head :not_authorized
          end
        end
      end
    end
  end
end
