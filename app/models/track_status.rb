class TrackStatus
  attr_reader :id,
              :status

  def initialize(track_id, status)
    @id = track_id
    @status = status
  end

  def self.user_saved?(info, user)
    status = service(user).user_saved?(info[:id])[0]
    TrackStatus.new(info[:id], status)
  end

  def self.save_or_remove(info, user)
    status = service(user).save_track(info[:ids]) if info[:type]
    status = service(user).remove_track(info[:id]) unless info[:type]
    TrackStatus.new(info[:id], status)
  end

  def self.service(user)
    @service ||= SpotifyService.new(user)
  end
end
