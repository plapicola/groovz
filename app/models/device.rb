class Device
  attr_reader :id,
              :name

  def initialize(device_info)
    @name = device_info[:name]
    @id = device_info[:id]
  end

  def self.for_user(user)
    service = UserSpotifyService.new(user)
    device_list = service.devices
    device_list.map do |device_info|
      Device.new(device_info)
    end
  end
end
