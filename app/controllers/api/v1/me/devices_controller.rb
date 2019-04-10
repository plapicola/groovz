# frozen_string_literal: true

module Api
  module V1
    module Me
      class DevicesController < ApplicationController
        def index
          render json: DevicesSerializer.new(Device.for_user(current_user))
        end
      end
    end
  end
end
