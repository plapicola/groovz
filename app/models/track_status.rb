class TrackStatus
  attr_reader :id,
              :status

  def initialize(track_id, status)
    @id = track_id
    @status = status
  end

  def self.user_saved?(track_id, user)
    status = service(user).user_saved?(track_id)[0]
    TrackStatus.new(track_id, status)
  end

  def self.save_or_remove(track_id, type, user)
    status = service(user).save_track(track_id) if type
    status = service(user).remove_track(track_id) unless type
    TrackStatus.new(track_id, status)
  end

  def self.service(user)
    @service ||= SpotifyService.new(user)
  end
end
