module Api
  module V1
    module Me
      module Playback
        class PausePlayController < ApplicationController
          skip_forgery_protection

          def update
            party = current_user.party
            service = PlaylistSpotifyService.new(current_user)
            if party.playing
              service.send_pause
            else
              service.send_play
            end
          end
        end
      end
    end
  end
end
