class CreatePartyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    party = Party.generate_party(args[0])
    party.setup_playlist
    UpdatePlaylistJob.perform_later(party.id)
  end
end
