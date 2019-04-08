class UpdatePlaylistNameJob < ApplicationJob
  queue_as :default

  def perform(*args)
    party = Party.find(args[0])
    party.update_playlist_name
  end
end
