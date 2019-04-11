# frozen_string_literal: true

module Api
  module V1
    module Me
      class TrackStatusController < ApplicationController
        skip_forgery_protection

        def show
          render json: TrackStatusSerializer.new(TrackStatus.user_saved?(track_status_params, current_user))
        end

        def create
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
