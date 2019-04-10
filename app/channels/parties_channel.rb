# frozen_string_literal: true

class PartiesChannel < ApplicationCable::Channel
  def subscribed
    stream_from params[:room]
  end
end
