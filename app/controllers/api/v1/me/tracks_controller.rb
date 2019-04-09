module Api
  module V1
    module Me
      class TracksController < ApplicationController
        def show
          binding.pry
          render json: Track.user_saved?(params[:id], current_user)
        end
      end
    end
  end
end
