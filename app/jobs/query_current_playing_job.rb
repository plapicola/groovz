class QueryCurrentPlayingJob < ApplicationJob
  queue_as :default
  after_perform do |job|
    self.class.set(wait: 5.seconds).perform_later(job.arguments.first) if @party
  end

  def perform(id)
    if party(id)&.new_song?
      ActionCable.server.broadcast(
        "parties-#{@party.code}",
        message: PartyTrackSerializer.new(@party.current_song)
      )
    end
  end

  private

  def party(id)
    @party ||= Party.find_by_id(id)
  end
end
