class PartiesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'parties'
  end
end
