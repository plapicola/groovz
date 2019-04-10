# frozen_string_literal: true

class UpdatePlaylistJob < ApplicationJob
  queue_as :default

  def perform(*args)
    party = Party.find(args[0])
    party.repopulate_playlist
  end
end
