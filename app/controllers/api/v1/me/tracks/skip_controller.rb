# frozen_string_literal: true

module Api
  module V1
    module Me
      module Tracks
        class SkipController < ApplicationController
          skip_forgery_protection

          def update
            TracksSpotifyService.new(current_user).skip_current_track
            head :ok
          end
        end
      end
    end
  end
end
