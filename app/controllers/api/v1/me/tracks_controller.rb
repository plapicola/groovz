module Api
  module V1
    module Me
      class TracksController < ApplicationController
        def show
          render json: PartyTrackSerializer.new(current_user.party&.current_song)
        end
      end
    end
  end
end
