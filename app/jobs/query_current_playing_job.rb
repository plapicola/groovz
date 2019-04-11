# frozen_string_literal: true

class QueryCurrentPlayingJob < ApplicationJob
  queue_as :default
  after_perform do |job|
    self.class.set(wait: 5.seconds).perform_later(job.arguments.first) if @party
  end

  def perform(id)
    current_playback = party(id).playing
    broadcast_song
    broadcast_playback(id, current_playback)
  end

  private

  def broadcast_song
    if @party&.new_song?
      ActionCable.server.broadcast(
        "parties-#{@party.code}",
        message: PartyTrackSerializer.new(@party.current_song)
      )
    end
  end

  def broadcast_playback(id, current_playback)
    updated_playback = Party.find_by_id(id).playing
    unless current_playback == updated_playback
      ActionCable.server.broadcast(
        "parties-#{@party.code}",
        message: {playing: updated_playback}
      )
    end
  end

  def party(id)
    @party ||= Party.find_by_id(id)
  end
end
