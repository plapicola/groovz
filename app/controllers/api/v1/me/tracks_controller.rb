module Api
  module V1
    module Me
      class TracksController < ApplicationController
        def show
          render json: TrackStatusSerializer.new(TrackStatus.user_saved?(params[:id], current_user))
        end
      end
    end
  end
end
