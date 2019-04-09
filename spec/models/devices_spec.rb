require 'rails_helper'

describe Device do
  it 'exists' do
    device_info = {
            id: "1c98de8059bd26890c14444a92048b4f6aaec837",
            name: "DESKTOP-PHC270L",
        }
    device = Device.new(device_info)

    expect(device).to be_a Device
  end

  it 'has attributes' do
    device_info = {
            id: "1c98de8059bd26890c14444a92048b4f6aaec837",
            name: "DESKTOP-PHC270L",
        }
    device = Device.new(device_info)

    expect(device).to be_a Device
  end

  describe 'class methods' do
    describe '.available_devices(user)' do
      it 'returns an array of devices availble for a user' do
        VCR.use_cassette('requests/devices') do
          user = create(:user)
          devices = Device.for_user(user)

          expect(devices).to be_a Array
          expect(devices[0]).to be_a Device
        end
      end
    end
  end
end
