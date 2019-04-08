module Api
  module V1
    module Me
      class DevicesController < ApplicationController
        def index
          render json: DevicesSerializer.new(Devices.available_devices(current_user))
        end
      end
    end
  end
end
