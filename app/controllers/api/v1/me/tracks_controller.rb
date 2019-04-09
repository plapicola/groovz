module Api
  module V1
    module Me
      class TracksController < ApplicationController
        def show
          render json: TrackStatusSerializer.new(TrackStatus.user_saved?(track_status_params, current_user))
        end

        def create
          binding.pry
          render json: TrackStatusSerializer.new(TrackStatus.save_or_remove(track_status_params, current_user))
        end

        private

        def track_status_params
          params.permit(:id, :type)
        end
      end
    end
  end
end
