# frozen_string_literal: true

class UpdatePlaylistNameJob < ApplicationJob
  queue_as :default

  def perform(*args)
    party = Party.find(args[0])
    party.update_playlist_name
    QueryCurrentPlayingJob.perform_later(party.id)
  end
end
