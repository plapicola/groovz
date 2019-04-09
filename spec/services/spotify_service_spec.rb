require 'rails_helper'

RSpec.describe SpotifyService do
  it 'exists' do
    user = create(:user)
    service = SpotifyService.new(user)

    expect(service).to be_a SpotifyService
  end

  describe 'instance methods' do
    describe '.devices' do
      it 'returns a list of available devices for the user' do
        user = create(:user)
        service = UserSpotifyService.new(user)

        devices = VCR.use_cassette('services/available_devices') do
         service.devices
        end

        expect(devices).to be_a Array
        expect(devices[0]).to have_key :id
        expect(devices[0]).to have_key :name
      end
    end
  end
end
