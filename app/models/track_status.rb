class TrackStatus
  attr_reader :id,
              :status

  def initialize(track_id, status)
    @id = track_id
    @status = status
  end

  def self.user_saved?(track_id, user)
    service = SpotifyService.new(user)
    status = service.user_saved?(track_id)[0]
    TrackStatus.new(track_id, status)
  end
end
